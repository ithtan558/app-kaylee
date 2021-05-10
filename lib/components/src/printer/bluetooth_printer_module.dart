import 'dart:convert';
import 'dart:typed_data';

import 'package:anth_package/anth_package.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';

class BluetoothPrinterModule {
  static late BluetoothPrint bluetoothPrint;
  static bool connected = false;

  static Future<void> init() async {
    bluetoothPrint = BluetoothPrint.instance;
  }

  static Uint8List? _tempData;

  static Future printOrder({
    required BuildContext context,
    Uint8List? data,
    VoidCallback? onFinished,
    VoidCallback? onLoading,
  }) async {
    onLoading?.call();
    if (data == null && _tempData == null) {
      return;
    } else
      data = _tempData;
    String base64Image = base64Encode(data!);
    List<LineText> list = [];
    list.add(LineText(
        type: LineText.TYPE_IMAGE,
        content: base64Image,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    onFinished?.call();
    _tempData = null;
    try {
      bluetoothPrint.printReceipt(Map(), list);
    } catch (e) {}
    return;
  }

  BluetoothPrinterModule._();
}
