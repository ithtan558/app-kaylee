part of '../base/printer_detail_base.dart';

mixin BluetoothPrinterMixin on PrinterDetailBase {
  @override
  void printBluetoothConnectionInfo() async {
    emit(PrinterDetailStatePrintingConnectionInfo());
    final list = [
      LineText(
          type: LineText.TYPE_TEXT,
          content:
              'Connected ${connectedDevice?.name}:${connectedDevice?.address}',
          align: LineText.ALIGN_LEFT,
          linefeed: 1)
    ];
    final result = await BluetoothPrint.instance.printReceipt(Map(), list);
    print('[TUNG] ===> printConnectionInfo printReceipt result $result');
    emit(PrinterDetailStateFinishPrintingConnectionInfo());
  }

  void checkBluetoothEnable() async {
    emit(PrinterDetailStateBluetoothCheckingEnable());
    final result = await BluetoothPrinterModule.bluetoothPrint.isOn;
    if (result)
      return emit(PrinterDetailStateBluetoothEnable());
    else
      return emit(PrinterDetailStateBluetoothNotEnable());
  }

  @override
  Future startScanBluetoothDevice() {
    return BluetoothPrint.instance.startScan(timeout: Duration(seconds: 1));
  }

  void savedBluetoothDeviceAsDefault() {
    emit(PrinterDetailStateSavedDefaultDeviceBluetooth());
    startConnectingBluetoothDevice();
  }

  void startConnectingBluetoothDevice();
}
