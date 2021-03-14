import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:anth_package/anth_package.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/components/src/printer/model/printer_device.dart';
import 'package:kaylee/components/src/printer/printer_module.dart';

class BluetoothPrinterModule {
  static BluetoothPrint bluetoothPrint;
  static bool connected = false;

  static Future<void> init() async {
    bluetoothPrint = BluetoothPrint.instance;
  }

  static Future findDevices() {
    return bluetoothPrint.startScan(timeout: Duration(seconds: 4));
  }

  static Future<void> connect({PrinterDevice device}) async {
    if (device.isNull) return;
    final d = BluetoothDevice.fromJson(device.toJson());
    return bluetoothPrint.connect(d);
  }

  static Future<bool> printConnectionInfo({PrinterDevice device}) async {
    if ((Platform.isIOS && connected) || await bluetoothPrint.isConnected) {
      final list = [
        LineText(
            type: LineText.TYPE_TEXT,
            content: 'Connected ${device.name}:${device.address}',
            align: LineText.ALIGN_LEFT,
            linefeed: 1)
      ];
      bluetoothPrint.printReceipt(Map(), list);
      return true;
    } else {
      await connect(device: device);
      return false;
    }
  }

  static Stream<int> listenConnectionState() {
    return bluetoothPrint.state;
  }

  static Uint8List _tempData;

  static Future printOrder({
    BuildContext context,
    Uint8List data,
    VoidCallback onFinished,
    VoidCallback onLoading,
  }) async {
    onLoading?.call();
    if ((Platform.isIOS && connected) || await bluetoothPrint.isConnected) {
      if (data.isNull) {
        if (_tempData.isNull)
          return;
        else
          data = _tempData;
      }
      String base64Image = base64Encode(data);
      List<LineText> list = List();
      list.add(LineText(
          type: LineText.TYPE_IMAGE,
          content: base64Image,
          align: LineText.ALIGN_LEFT,
          linefeed: 1));
      await bluetoothPrint.printReceipt(Map(), list);
      _tempData = null;
      onFinished?.call();
      return;
    } else {
      onFinished?.call();

      final device = PrinterModule.connectedDevice;
      showKayleeDialogNotAbleToConnectPrinter(
        context: context,
        onTryAgain: () async {
          if (_tempData.isNull) {
            _tempData = data;
          }
          onLoading?.call();
          await connect(device: device);
        },
      );
      return;
    }
  }

  static PrinterDevice getPrinterDevice() {
    final fromSharePref = SharedRef.getString(PRINTER_DEVICES_KEY);
    final map =
        jsonDecode(fromSharePref.isNullOrEmpty ? '[]' : fromSharePref) as List;
    final devices = map.map((e) => PrinterDevice.fromJson(e)).toList();
    final device = devices.firstWhere(
      (element) => element.isBluetooth && element.selected,
      orElse: () => null,
    );
    return device;
  }

  BluetoothPrinterModule._();
}
