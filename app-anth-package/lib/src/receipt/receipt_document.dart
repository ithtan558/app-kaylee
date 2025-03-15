import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

abstract class ReceiptDocument<Data> {
  Future<Document> forRoll80(Data data);

  Future<Document> forRoll57(Data data);

  Future<Document> buildDocument({
    double ratio = 1,
    required Widget Function(Context context, ThemeData theme) builder,
    PdfPageFormat format = PdfPageFormat.a3,
  }) async {
    final doc = await generateDocument(ratio: ratio);
    final theme = doc.theme!;
    doc.addPage(Page(
      pageTheme: PageTheme(
        buildBackground: (context) =>
            Container(color: const PdfColor.fromInt(0xFFFFFFFF)),
        pageFormat: (format)
            .copyWith(marginLeft: 0, marginRight: 0, height: double.infinity),
        clip: true,
        margin: EdgeInsets.zero,
      ),
      build: (context) => builder(context, theme),
    ));
    return doc;
  }
}

Future<Document> generateDocument({double ratio = 1}) async {
  final fonts = await _ReceiptFonts.loadFonts();
  final defaultTextStyle = TextStyle(
    fontNormal: Font.ttf(fonts[_FontsStyle.normal]!),
    fontItalic: Font.ttf(fonts[_FontsStyle.normalItalic]!),
    fontBold: Font.ttf(fonts[_FontsStyle.bold]!),
    fontBoldItalic: Font.ttf(fonts[_FontsStyle.boldItalic]!),
    font: Font.ttf(fonts[_FontsStyle.medium]!),
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

enum _FontsStyle {
  normal,
  normalItalic,
  medium,
  mediumItalic,
  bold,
  boldItalic
}

class _ReceiptFonts {
  _ReceiptFonts._();

  static Map<_FontsStyle, ByteData>? _fonts;

  static Future<Map<_FontsStyle, ByteData>> loadFonts() async {
    if (_fonts != null) return _fonts!;
    final normal = await _ReceiptFonts._normal();
    final normalItalic = await _ReceiptFonts._normalItalic();
    final medium = await _ReceiptFonts._medium();
    final mediumItalic = await _ReceiptFonts._mediumItalic();
    final bold = await _ReceiptFonts._bold();
    final boldItalic = await _ReceiptFonts._boldItalic();
    _fonts = {
      _FontsStyle.normal: normal,
      _FontsStyle.normalItalic: normalItalic,
      _FontsStyle.medium: medium,
      _FontsStyle.mediumItalic: mediumItalic,
      _FontsStyle.bold: bold,
      _FontsStyle.boldItalic: boldItalic,
    };
    return _fonts!;
  }

  static const String _receiptFontsPath =
      'packages/anth_package/receipt_fonts/';

  static Future _normal() =>
      rootBundle.load(_receiptFontsPath + 'Roboto-Regular.ttf');

  static Future _normalItalic() =>
      rootBundle.load(_receiptFontsPath + 'Roboto-Italic.ttf');

  static Future _medium() =>
      rootBundle.load(_receiptFontsPath + 'Roboto-Medium.ttf');

  static Future _mediumItalic() =>
      rootBundle.load(_receiptFontsPath + 'Roboto-MediumItalic.ttf');

  static Future _bold() =>
      rootBundle.load(_receiptFontsPath + 'Roboto-Bold.ttf');

  static Future _boldItalic() =>
      rootBundle.load(_receiptFontsPath + 'Roboto-BoldItalic.ttf');
}
