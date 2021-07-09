part of 'base/printer_detail_base.dart';

class IosPrinterDetailBloc extends PrinterDetailBase
    with BluetoothPrinterMixin, IosBluetoothPrinterMixin, WifiPrinterMixin {
  IosPrinterDetailBloc() : super._();
}

class IosPrinterDialogBloc extends IosPrinterDetailBloc {
  IosPrinterDialogBloc() : super();
}
