part of 'printer_detail_bloc.dart';

mixin WifiPrinterMixin on PrinterDetailBase {
  @override
  void savedWifiDeviceAsDefault() {
    emit(PrinterDetailStateSavedDefaultDeviceWifi());
  }
}
