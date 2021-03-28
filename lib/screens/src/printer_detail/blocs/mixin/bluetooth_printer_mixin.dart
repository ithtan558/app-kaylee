part of '../base/printer_detail_base.dart';

mixin BluetoothPrinterMixin on PrinterDetailBase {
  StreamSubscription _bluetoothSub;

  @override
  void printBluetoothConnectionInfo() async {
    emit(PrinterDetailStatePrintingConnectionInfo());
    // final list = [
    //   LineText(
    //       type: LineText.TYPE_TEXT,
    //       content: 'Connected ${defaultDevice?.name}:${defaultDevice?.address}',
    //       align: LineText.ALIGN_LEFT,
    //       linefeed: 1)
    // ];
    // try {
    //   BluetoothPrint.instance.printReceipt(Map(), list);
    //   print('[TUNG] ===> printConnectionInfo printReceipt result ');
    // } catch (e) {
    //   return lostConnectionToBluetoothDevice();
    // }
    emit(PrinterDetailStateFinishPrintingConnectionInfo());
  }

  void checkBluetoothEnable() async {
    print('[TUNG] ===> start checkBluetoothEnable ');
    emit(PrinterDetailStateBluetoothCheckingEnable());
    // final result = await BluetoothPrinterModule.bluetoothPrint.isOn;
    // print('[TUNG] ===> checkBluetoothEnable ${result}');
    // if (result)
    //   return emit(PrinterDetailStateBluetoothEnable());
    // else
    //   return emit(PrinterDetailStateBluetoothNotEnable());
  }

  @override
  Future startScanBluetoothDevice() {
    // return BluetoothPrint.instance.startScan(timeout: Duration(seconds: 1));
  }

  @override
  void onRemoveBluetoothDevice() async {
    emit(PrinterDetailStateRemovingConnectionBluetoothDevice());
    emit(PrinterDetailStateRemovedConnectionBluetoothDevice());
  }

  void savedBluetoothDeviceAsDefault() {
    emit(PrinterDetailStateSavedDefaultDeviceBluetooth());
    startConnectingBluetoothDevice();
  }

  Future connect() async {
    if (defaultDevice.isNull) return;
    // final d = BluetoothDevice.fromJson(defaultDevice.toJson());
    // return BluetoothPrint.instance.connect(d);
  }

  @override
  Future<void> close() async {
    _bluetoothSub?.cancel();
    // await BluetoothPrint.instance.stopScan();
    return super.close();
  }

  void lostConnectionToBluetoothDevice() {
    emit(PrinterDetailStateLostConnectionBluetoothDevice());
  }
}
