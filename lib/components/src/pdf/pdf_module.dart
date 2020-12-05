import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfModule {
  static Future<Document> generateDocument() async {
    final fonts = await loadFonts();
    final defaultTextStyle = TextStyle(
      fontNormal: Font.ttf(fonts[FontsStyle.normal]),
      fontItalic: Font.ttf(fonts[FontsStyle.normalItalic]),
      fontBold: Font.ttf(fonts[FontsStyle.bold]),
      fontBoldItalic: Font.ttf(fonts[FontsStyle.boldItalic]),
      font: Font.ttf(fonts[FontsStyle.medium]),
      fontSize: 30,
    );
    final doc = Document(
      theme: ThemeData(
        defaultTextStyle: defaultTextStyle,
        header0: defaultTextStyle.merge(TextStyle(fontSize: 35)),
        header1: defaultTextStyle.merge(TextStyle(fontSize: 40)),
        tableHeader: defaultTextStyle.merge(
          TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return doc;
  }

  static Future<Map<FontsStyle, ByteData>> loadFonts() async {
    final path = 'fonts/';
    final normal = await rootBundle.load(path + 'Roboto-Regular.ttf');
    final normalItalic = await rootBundle.load(path + 'Roboto-Italic.ttf');
    final medium = await rootBundle.load(path + 'Roboto-Medium.ttf');
    final mediumItalic =
        await rootBundle.load(path + 'Roboto-MediumItalic.ttf');
    final bold = await rootBundle.load(path + 'Roboto-Bold.ttf');
    final boldItalic = await rootBundle.load(path + 'Roboto-BoldItalic.ttf');
    return {
      FontsStyle.normal: normal,
      FontsStyle.normalItalic: normalItalic,
      FontsStyle.medium: medium,
      FontsStyle.mediumItalic: mediumItalic,
      FontsStyle.bold: bold,
      FontsStyle.boldItalic: boldItalic,
    };
  }

  static Future<Document> generateDocumentForOrder({Order order}) async {
    final doc = await generateDocument();
    final theme = doc.theme;
    doc.addPage(Page(
      pageTheme: PageTheme(
        buildBackground: (context) =>
            Container(color: PdfColor.fromInt(0xFFFFFFFF)),
        pageFormat: PdfPageFormat.a3
            .copyWith(marginLeft: 0, marginRight: 0, height: double.infinity),
        clip: true,
        margin: EdgeInsets.zero,
      ),
      build: (context) {
        return Padding(
          padding: EdgeInsets.only(right: Dimens.px24, left: Dimens.px4),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${order.brand.name ?? ''}',
                    style: theme.header1.merge(TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px16),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'ĐC: ${order.brand.location ?? ''}',
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px16),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'ĐT: ${order.brand.phone}',
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px16),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  Strings.hoadDonBanHang.toUpperCase(),
                  style: doc.theme.header0.merge(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px16),
              child: Row(
                children: [
                  Text(
                    '${Strings.ngay}: ${order.createdAt?.toFormatString(pattern: dateFormat2) ?? ''}',
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    '${Strings.so}: ${order.code ?? ''}',
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px8),
              child: Text(
                '${Strings.khachHang}: ${order.customer?.name ?? ''}',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px8),
              child: Text(
                '${Strings.nhanVien}: ${order.employee?.name ?? ''}',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px16),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(3),
                  3: FlexColumnWidth(3),
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
                        ),
                        _wrapPaddingAll(
                          child: Text(
                            'SL',
                            style: theme.defaultTextStyle.merge(
                              TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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
                        ),
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
                        ),
                      ],
                      decoration: BoxDecoration(
                          border: BoxBorder(
                              width: Dimens.px3,
                              style: BorderStyle.dashed,
                              top: true,
                              left: true,
                              bottom: true,
                              right: true,
                              color: PdfColor.fromInt(0xff000000)))),
                  ...?_getProductTableRow(order.orderItems),
                ],
              ),
            ),
            ..._getPaymentInfo(order, theme: theme),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px24),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(Strings.camOnQuyKhachHenGapLai,
                    style: theme.defaultTextStyle.merge(
                      TextStyle(fontStyle: FontStyle.italic),
                    )),
              ]),
            ),
          ]),
        );
      },
    ));
    return doc;
  }

  static List<TableRow> _getProductTableRow(List<OrderItem> products) {
    Widget _getProductCell(String text, {TextAlign textAlign}) {
      return _wrapPaddingAll(
        child: Text(
          text ?? '',
          textAlign: textAlign,
        ),
      );
    }

    return products
        ?.map(
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
              border: BoxBorder(
                width: Dimens.px3,
                style: BorderStyle.dashed,
                left: true,
                right: true,
                bottom: true,
                color: PdfColor.fromInt(0xff000000),
              ),
            ),
          ),
        )
        ?.toList();
  }

  static List<Widget> _getPaymentInfo(Order order, {ThemeData theme}) {
    return [
      Padding(
        padding: EdgeInsets.only(top: Dimens.px30),
        child: _getAmountText(
            title: Strings.tong,
            content: CurrencyUtils.formatVNDWithCustomUnit(order.total ?? 0),
            style: theme.defaultTextStyle
                .merge(TextStyle(fontWeight: FontWeight.bold))),
      ),
      Padding(
        padding: EdgeInsets.only(top: Dimens.px8),
        child: _getAmountText(
            title: Strings.giamGia,
            content: CurrencyUtils.formatVNDWithCustomUnit(order.discount ?? 0),
            style: theme.defaultTextStyle
                .merge(TextStyle(fontWeight: FontWeight.bold))),
      ),
      Padding(
        padding: EdgeInsets.only(top: Dimens.px8),
        child: _getAmountText(
          title: Strings.thanhTien,
          content: CurrencyUtils.formatVNDWithCustomUnit(order.amount ?? 0),
          style: theme.header1.merge(TextStyle(fontWeight: FontWeight.bold)),
        ),
      )
    ];
  }

  static Widget _getAmountText(
      {String title, String content, TextStyle style}) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: style,
        ),
        Expanded(child: SizedBox()),
        Text(
          content ?? '',
          style: style,
        ),
      ],
    );
  }

  static Widget _wrapPaddingAll({double padding = Dimens.px8, Widget child}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}

enum FontsStyle { normal, normalItalic, medium, mediumItalic, bold, boldItalic }
