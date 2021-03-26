part of '../base/printer_detail_base.dart';

mixin WifiPrinterMixin on PrinterDetailBase {
  @override
  void savedWifiDeviceAsDefault() {
    emit(PrinterDetailStateSavedDefaultDeviceWifi());
  }

  @override
  void onRemoveWifiDevice() {}
}
