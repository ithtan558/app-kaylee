part of '../base/printer_detail_base.dart';

mixin BluetoothPrinterMixin on PrinterDetailBase {
  late StreamSubscription _bluetoothSub;

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
    try {
      BluetoothPrint.instance.printReceipt({}, list);
      // print('[TUNG] ===> printConnectionInfo printReceipt result ');
    } catch (e) {
      return lostConnectionToBluetoothDevice();
    }
    emit(PrinterDetailStateFinishPrintingConnectionInfo());
  }

  @override
  void checkBluetoothEnable() async {
    // print('[TUNG] ===> start checkBluetoothEnable ');
    emit(PrinterDetailStateBluetoothCheckingEnable());
    final result = await BluetoothPrint.instance.isOn;
    // print('[TUNG] ===> checkBluetoothEnable $result');
    if (result) {
      return emit(PrinterDetailStateBluetoothEnable());
    } else {
      return emit(PrinterDetailStateBluetoothNotEnable());
    }
  }

  @override
  Future startScanBluetoothDevice() {
    return BluetoothPrint.instance
        .startScan(timeout: const Duration(seconds: 1));
  }

  @override
  void onRemoveBluetoothDevice() async {
    emit(PrinterDetailStateRemovingConnectionBluetoothDevice());
    emit(PrinterDetailStateRemovedConnectionBluetoothDevice());
  }

  @override
  void savedBluetoothDeviceAsDefault() {
    emit(PrinterDetailStateSavedDefaultDeviceBluetooth());
    startConnectingBluetoothDevice();
  }

  Future connect() async {
    if (defaultDevice == null) return;
    final d = BluetoothDevice.fromJson(defaultDevice!.toJson());
    return BluetoothPrint.instance.connect(d);
  }

  @override
  Future<void> close() async {
    _bluetoothSub.cancel();
    await BluetoothPrint.instance.stopScan();
    return super.close();
  }

  void lostConnectionToBluetoothDevice() {
    emit(PrinterDetailStateLostConnectionBluetoothDevice());
  }
}
