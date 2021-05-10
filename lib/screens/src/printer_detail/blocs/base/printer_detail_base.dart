import 'dart:async';
import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/components/src/printer/bluetooth_printer_module.dart';

part '../android_printer_detail_bloc.dart';
part '../ios_printer_detail_bloc.dart';
part '../mixin/android/android_bluetooth_printer_mixin.dart';
part '../mixin/bluetooth_printer_mixin.dart';
part '../mixin/ios/ios_bluetooth_printer_mixin.dart';
part '../mixin/wifi_printer_mixin.dart';
part '../state/printer_detail_state.dart';

abstract class PrinterDetailBase extends Cubit<PrinterDetailState> {
  PrinterDetailBase._() : super(PrinterDetailStateInitial()) {
    init();
  }

  void init() {}

  List<PrinterDevice> devices = [];

  PrinterDevice get _selectedDevice => devices.firstWhere(
        (element) => element.selected,
        orElse: () => null,
      );

  PrinterDevice get defaultDevice {
    final fromSharePref = SharedRef.getString(PRINTER_DEVICES_KEY);
    final map =
        jsonDecode(fromSharePref.isNullOrEmpty ? '[]' : fromSharePref) as List;
    return map.map((e) => PrinterDevice.fromJson(e)).firstWhere(
          (element) => element.selected,
          orElse: () => null,
        );
  }

  void initState() async {
    emit(PrinterDetailStateLoadingDevices());
    final fromSharePref = SharedRef.getString(PRINTER_DEVICES_KEY);
    final map =
        jsonDecode(fromSharePref.isNullOrEmpty ? '[]' : fromSharePref) as List;
    devices = map.map((e) => PrinterDevice.fromJson(e)).toList();
    //todo remove vì chưa setup xong bluetooth
    // await startScanBluetoothDevice();
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

  void onAddWifi({required String ip}) {
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
    final isDefault = defaultDevice.isNull
        ? false
        : defaultDevice.deviceAddress == device.deviceAddress;
    devices.removeWhere((e) {
      return e.isEqual(device);
    });
    _updateSharedPref();
    emit(PrinterDetailStateLoadedDevices());
    if (device.isBluetooth) {
      if (isDefault) {
        return onRemoveBluetoothDevice();
      }
    } else if (device.isWifi) {
      onRemoveWifiDevice();
    }
  }

  void _updateSharedPref() {
    SharedRef.putString(PRINTER_DEVICES_KEY, jsonEncode(devices));
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

    if (defaultDevice?.deviceAddress == device.deviceAddress) {
      return emit(PrinterDetailStateOnNoSelectingDevice());
    }
    emit(PrinterDetailStateOnSelectingDevice());
  }

  void savedWifiDeviceAsDefault();

  void savedBluetoothDeviceAsDefault();

  void onRemoveBluetoothDevice();

  void onRemoveWifiDevice();

  void printBluetoothConnectionInfo();

  void checkBluetoothEnable();

  Future startScanBluetoothDevice();

  void startConnectingBluetoothDevice();

  void saveDefaultDevice() {
    _updateSharedPref();
    final device = _selectedDevice;
    if (device.isNotNull) {
      if (device.isBluetooth) {
        return savedBluetoothDeviceAsDefault();
      } else if (device.isWifi) {
        return savedWifiDeviceAsDefault();
      }
    }
  }
}
