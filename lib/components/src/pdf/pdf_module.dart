import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfModule {
  static Future<Document> generateDocument({double ratio = 1}) async {
    final fonts = await loadFonts();
    final defaultTextStyle = TextStyle(
      fontNormal: Font.ttf(fonts[FontsStyle.normal]!),
      fontItalic: Font.ttf(fonts[FontsStyle.normalItalic]!),
      fontBold: Font.ttf(fonts[FontsStyle.bold]!),
      fontBoldItalic: Font.ttf(fonts[FontsStyle.boldItalic]!),
      font: Font.ttf(fonts[FontsStyle.medium]!),
      fontSize: 30 / ratio,
    );
    final doc = Document(
      theme: ThemeData(
        defaultTextStyle: defaultTextStyle,
        header0: defaultTextStyle.merge(TextStyle(fontSize: 35 / ratio)),
        header1: defaultTextStyle.merge(TextStyle(fontSize: 40 / ratio)),
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

  static Future<Document> generateDocumentForOrder(
      {required Order order,
      double ratio = 1,
      EdgeInsets? padding,
      PdfPageFormat? format}) async {
    final doc = await generateDocument(ratio: ratio);
    final theme = doc.theme;
    doc.addPage(Page(
      pageTheme: PageTheme(
        buildBackground: (context) =>
            Container(color: PdfColor.fromInt(0xFFFFFFFF)),
        pageFormat: (format ?? PdfPageFormat.a3)
            .copyWith(marginLeft: 0, marginRight: 0, height: double.infinity),
        clip: true,
        margin: EdgeInsets.zero,
      ),
      build: (context) {
        return Padding(
          padding:
              padding ?? EdgeInsets.only(right: Dimens.px24, left: Dimens.px4),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${order.brand?.name ?? ''}',
                    style:
                        theme!.header1.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px16 / ratio),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'ĐC: ${order.brand?.location ?? ''}',
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px16 / ratio),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'ĐT: ${order.brand?.phone}',
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px16 / ratio),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  Strings.hoadDonBanHang.toUpperCase(),
                  style: doc.theme!.header0.merge(
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
                  Expanded(child: SizedBox()),
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
                        '${employee.name}' +
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
                              color: PdfColor.fromInt(0xff000000)))),
                  ...?_getProductTableRow(order.orderItems, ratio: ratio),
                ],
              ),
            ),
            ..._getPaymentInfo(order, theme: theme, ratio: ratio),
            Padding(
              padding: EdgeInsets.only(top: Dimens.px24 / ratio),
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

  static Future<Document> generateDocumentForOrderForRoll57(
      {required Order order, double ratio = 1}) async {
    return generateDocumentForOrder(
        order: order,
        ratio: 5.6,
        padding: EdgeInsets.only(right: Dimens.px56),
        format: PdfPageFormat.roll57);
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
              color: PdfColor.fromInt(0xff000000),
            ),
            right: BorderSide(
              width: Dimens.px3 / ratio,
              style: BorderStyle.dashed,
              color: PdfColor.fromInt(0xff000000),
            ),
            bottom: BorderSide(
              width: Dimens.px3 / ratio,
              style: BorderStyle.dashed,
              color: PdfColor.fromInt(0xff000000),
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
        Expanded(child: SizedBox()),
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

enum FontsStyle { normal, normalItalic, medium, mediumItalic, bold, boldItalic }

void getPdfRaster(
    {required Future<Uint8List> data,
    required double dpi,
    required ValueSetter<Uint8List?> onPrint}) async {
  final raster = Printing.raster(
    await data,
    dpi: dpi,
  );

  await for (var page in raster) {
    ui.Image image = await page.toImage(); // ...or page.toPng()
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    onPrint.call((byteData?.buffer)?.asUint8List());
  }
}

///get raster cho khổ 57
void getPdfRasterForRol57(
    {required Future<Uint8List> data,
    required ValueSetter<Uint8List> onPrint}) {
  return getPdfRaster(
      data: data,
      dpi: 300,
      onPrint: (value) {
        if (value != null) {
          final decodedImage = image.decodeImage(value);
          if (decodedImage != null) {
            final jpgEncoded = image.encodeJpg(decodedImage);
            onPrint.call(Uint8List.fromList(jpgEncoded));
          }
        }
      });
}

///get raster cho khổ 80
void getPdfRasterForRol80(
    {required Future<Uint8List> data,
    required ValueSetter<image.Image> onPrint}) {
  return getPdfRaster(
    data: data,
    dpi: 50,
    onPrint: (value) {
      if (value != null) {
        final decodedImage = image.decodeImage(value);
        if (decodedImage != null) {
          onPrint.call(decodedImage);
        }
      }
    },
  );
}
