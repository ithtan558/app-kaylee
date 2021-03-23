import 'dart:convert';

import 'package:core_plugin/core_plugin.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/components/src/printer/bluetooth_printer_module.dart';

part 'printer_detail_state.dart';

class PrinterDetailBloc extends Cubit<PrinterDetailState> {
  PrinterDetailBloc() : super(PrinterDetailStateInitial());

  List<PrinterDevice> devices = [];

  void initState() {
    emit(PrinterDetailStateLoadingDevices());
    final fromSharePref = SharedRef.getString(PRINTER_DEVICES_KEY);
    final map =
        jsonDecode(fromSharePref.isNullOrEmpty ? '[]' : fromSharePref) as List;
    devices = map.map((e) => PrinterDevice.fromJson(e)).toList();
    emit(PrinterDetailStateLoadedDevices());
  }

  void onSelectWifi() {
    emit(PrinterDetailStateOnSelectWifi());
  }

  void onSelectBluetooth() {
    emit(PrinterDetailStateOnSelectBluetooth());
  }

  void onAddBluetooth({PrinterDevice device}) {
    if (device.isNull) return;
    _addDevice(device);
    emit(PrinterDetailStateLoadedDevices());
  }

  void onAddWifi({String ip}) {
    if (ip.isNullOrEmpty) return;
    final device = PrinterDevice.wifi(ip: ip);
    _addDevice(device);
    emit(PrinterDetailStateLoadedDevices());
  }

  void _addDevice(PrinterDevice device) {
    final existIndex = devices.indexWhere((e) => e.isEqual(device));
    if (existIndex.isNegative) {
      devices.add(device);
      _updateSharedPref();
    }
  }

  void removeDevice({PrinterDevice device}) {
    devices.removeWhere((e) {
      return e.isEqual(device);
    });
    _updateSharedPref();
    emit(PrinterDetailStateLoadedDevices());
  }

  void _updateSharedPref() {
    SharedRef.putString(PRINTER_DEVICES_KEY, jsonEncode(devices));
  }

  void saveDefaultDevice() {
    _updateSharedPref();
    final selectedDevice = connectedDevice;
    if (selectedDevice.isNotNull) {
      if (selectedDevice.isBluetooth) {
        emit(PrinterDetailStateSavedDefaultDeviceBluetooth());
      } else if (selectedDevice.isWifi) {
        emit(PrinterDetailStateSavedDefaultDeviceWifi());
      }
    }
  }

  void select({PrinterDevice device}) {
    if (device.selected) {
      device.selected = false;
      return emit(PrinterDetailStateOnNoSelectingDevice());
    }

    //bỏ select của device đã chọn trc đó
    final oldSelected = devices.firstWhere(
      (element) => element.selected,
      orElse: () => null,
    );
    oldSelected?.selected = false;

    //set true cho device mới vừa chọn
    device.selected = true;

    emit(PrinterDetailStateOnSelectingDevice());
  }

  PrinterDevice get connectedDevice => devices.firstWhere(
        (element) => element.selected,
        orElse: () => null,
      );

  void checkBluetoothEnable() async {
    emit(PrinterDetailStateBluetoothCheckingEnable());
    final result = await BluetoothPrinterModule.bluetoothPrint.isOn;
    if (result)
      return emit(PrinterDetailStateBluetoothEnable());
    else
      return emit(PrinterDetailStateBluetoothNotEnable());
  }
}
