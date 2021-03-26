part of '../base/printer_detail_base.dart';

mixin BluetoothPrinterMixin on PrinterDetailBase {
  StreamSubscription _bluetoothSub;

  @override
  void printBluetoothConnectionInfo() async {
    emit(PrinterDetailStatePrintingConnectionInfo());
    final list = [
      LineText(
          type: LineText.TYPE_TEXT,
          content: 'Connected ${defaultDevice?.name}:${defaultDevice?.address}',
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

  @override
  void onRemoveBluetoothDevice() async {
    emit(PrinterDetailStateRemovingConnectionBluetoothDevice());
    final result = await BluetoothPrint.instance.disconnect();
    emit(PrinterDetailStateRemovedConnectionBluetoothDevice());
  }

  void savedBluetoothDeviceAsDefault() {
    emit(PrinterDetailStateSavedDefaultDeviceBluetooth());
    startConnectingBluetoothDevice();
  }

  void startConnectingBluetoothDevice();

  Future connect() async {
    if (defaultDevice.isNull) return;
    final d = BluetoothDevice.fromJson(defaultDevice.toJson());
    return BluetoothPrint.instance.connect(d);
  }

  @override
  Future<void> close() async {
    _bluetoothSub?.cancel();
    await BluetoothPrint.instance.stopScan();
    return super.close();
  }
}
