part of 'base/printer_detail_base.dart';

class AndroidPrinterDetailBloc extends PrinterDetailBase
    with BluetoothPrinterMixin, AndroidBluetoothPrinterMixin, WifiPrinterMixin {
  AndroidPrinterDetailBloc() : super._();

  @override
  void initState() async {
    emit(PrinterDetailStateLoadingDevices());
    final fromSharePref = SharedRef.getString(printerDevicesKey);
    final map =
        jsonDecode(fromSharePref.isNullOrEmpty ? '[]' : fromSharePref!) as List;
    devices = map.map((e) => PrinterDevice.fromJson(e)).toList();
    emit(PrinterDetailStateLoadedDevices());
  }
}

class AndroidPrinterDialogBloc extends AndroidPrinterDetailBloc {
  AndroidPrinterDialogBloc() : super();
}
