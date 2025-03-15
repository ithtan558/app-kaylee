import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as image;
import 'package:printing/printing.dart';

void _getPdfRaster(
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
void getPdfRasterForRoll57(
    {required Future<Uint8List> data,
    required ValueSetter<Uint8List> onPrint}) {
  return _getPdfRaster(
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
void getPdfRasterForRoll80(
    {required Future<Uint8List> data,
    required ValueSetter<image.Image> onPrint}) {
  return _getPdfRaster(
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
