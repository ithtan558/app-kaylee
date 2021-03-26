part of 'base/printer_detail_base.dart';

class AndroidPrinterDetailBloc extends PrinterDetailBase
    with BluetoothPrinterMixin, AndroidBluetoothPrinterMixin, WifiPrinterMixin {
  AndroidPrinterDetailBloc() : super._();
}
