import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfDocument extends ReceiptDocument<Order> {
  @override
  Future<Document> forRoll57(Order data) {
    return buildDocument(
        ratio: 5.6,
        builder: (context, theme) {
          return _buildDocumentContent(
              order: data,
              theme: theme,
              ratio: 5.6,
              padding: const EdgeInsets.only(right: Dimens.px56));
        },
        format: PdfPageFormat.roll57);
  }

  @override
  Future<Document> forRoll80(Order data) {
    return buildDocument(builder: (context, theme) {
      return _buildDocumentContent(
        order: data,
        theme: theme,
      );
    });
  }

  Widget _buildDocumentContent({
    required Order order,
    required ThemeData theme,
    double ratio = 1,
    EdgeInsets padding =
        const EdgeInsets.only(right: Dimens.px24, left: Dimens.px4),
  }) {
    return Padding(
      padding: padding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(order.brand?.name ?? '',
                style: theme.header1.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px16 / ratio),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'ĐC: ${order.brand?.location ?? ''}',
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px16 / ratio),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'ĐT: ${order.brand?.phone}',
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px16 / ratio),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              Strings.hoadDonBanHang.toUpperCase(),
              style: theme.header0.merge(
                TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px16 / ratio),
          child: Row(
            children: [
              Text(
                '${Strings.ngay}: ${order.createdAt?.toFormatString(pattern: dateFormat2) ?? ''}',
              ),
              Expanded(child: SizedBox.shrink()),
              Text(
                '${Strings.so}: ${order.code ?? ''}',
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px8 / ratio),
          child: Text(
            '${Strings.khachHang}: ${order.customer?.name ?? ''}',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px8 / ratio),
          child: Text(
            '${Strings.nhanVienThucThien}:',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px8 / ratio),
          child: Column(
            children: List.generate(order.employees?.length ?? 0, (index) {
              final employee = order.employees!.elementAt(index);
              return Row(
                children: [
                  Expanded(
                      child: Text(
                    (employee.name ?? '') +
                        (employee.role?.name != null &&
                                employee.role!.name!.isNotEmpty
                            ? ' - ${employee.role!.name}'
                            : ''),
                  ))
                ],
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px16 / ratio),
          child: Table(
            columnWidths: {
              0: const FlexColumnWidth(4),
              1: const FlexColumnWidth(),
              2: const FlexColumnWidth(3),
              3: const FlexColumnWidth(3),
            },
            children: [
              TableRow(
                  children: [
                    _wrapPaddingAll(
                        child: Text(
                          Strings.matHang,
                          style: theme.defaultTextStyle.merge(
                            TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ratio: ratio),
                    _wrapPaddingAll(
                        child: Text(
                          'SL',
                          style: theme.defaultTextStyle.merge(
                            TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ratio: ratio),
                    _wrapPaddingAll(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                Strings.gia,
                                style: theme.defaultTextStyle.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                        ratio: ratio),
                    _wrapPaddingAll(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'T tiền',
                              style: theme.defaultTextStyle.merge(
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ratio: ratio),
                  ],
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: Dimens.px3 / ratio,
                          style: BorderStyle.dashed,
                          color: const PdfColor.fromInt(0xff000000)))),
              ...?_getProductTableRow(order.orderItems, ratio: ratio),
            ],
          ),
        ),
        ..._getPaymentInfo(order, theme: theme, ratio: ratio),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px24 / ratio),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(Strings.camOnQuyKhachHenGapLai,
                style: theme.defaultTextStyle.merge(
                  TextStyle(fontStyle: FontStyle.italic),
                )),
          ]),
        ),
      ]),
    );
  }

  static List<TableRow>? _getProductTableRow(List<OrderItem>? products,
      {double ratio = 1}) {
    Widget _getProductCell(String text, {TextAlign? textAlign}) {
      return _wrapPaddingAll(
        child: Text(
          text,
          textAlign: textAlign,
        ),
        ratio: ratio,
      );
    }

    return (products?.map(
      (product) => TableRow(
        children: [
          _getProductCell(
            product.name ?? '',
          ),
          _getProductCell(
            '${product.quantity}',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _getProductCell(
                CurrencyUtils.formatVNDWithCustomUnit(product.price ?? 0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _getProductCell(
                  CurrencyUtils.formatVNDWithCustomUnit(product.total ?? 0),
                  textAlign: TextAlign.right),
            ],
          ),
        ],
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: Dimens.px3 / ratio,
              style: BorderStyle.dashed,
              color: const PdfColor.fromInt(0xff000000),
            ),
            right: BorderSide(
              width: Dimens.px3 / ratio,
              style: BorderStyle.dashed,
              color: const PdfColor.fromInt(0xff000000),
            ),
            bottom: BorderSide(
              width: Dimens.px3 / ratio,
              style: BorderStyle.dashed,
              color: const PdfColor.fromInt(0xff000000),
            ),
          ),
        ),
      ),
    ))?.toList();
  }

  static List<Widget> _getPaymentInfo(Order order,
      {required ThemeData theme, double ratio = 1}) {
    return [
      Padding(
        padding: EdgeInsets.only(top: Dimens.px30 / ratio),
        child: _getAmountText(
            title: Strings.tong,
            content: CurrencyUtils.formatVNDWithCustomUnit(order.total),
            style: theme.defaultTextStyle
                .merge(TextStyle(fontWeight: FontWeight.bold))),
      ),
      Padding(
        padding: EdgeInsets.only(top: Dimens.px8 / ratio),
        child: _getAmountText(
            title: Strings.giamGia,
            content: CurrencyUtils.formatVNDWithCustomUnit(order.discount ?? 0),
            style: theme.defaultTextStyle
                .merge(TextStyle(fontWeight: FontWeight.bold))),
      ),
      Padding(
        padding: EdgeInsets.only(top: Dimens.px8 / ratio),
        child: _getAmountText(
          title: Strings.thanhTien,
          content: CurrencyUtils.formatVNDWithCustomUnit(order.amount ?? 0),
          style: theme.header1.merge(TextStyle(fontWeight: FontWeight.bold)),
        ),
      )
    ];
  }

  static Widget _getAmountText(
      {String? title, String? content, TextStyle? style}) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: style,
        ),
        Expanded(child: SizedBox.shrink()),
        Text(
          content ?? '',
          style: style,
        ),
      ],
    );
  }

  static Widget _wrapPaddingAll(
      {double padding = Dimens.px8, Widget? child, double ratio = 1}) {
    return Padding(
      padding: EdgeInsets.all(padding / ratio),
      child: child,
    );
  }
}