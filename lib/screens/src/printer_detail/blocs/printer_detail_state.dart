part of 'printer_detail_bloc.dart';

abstract class PrinterDetailState {}

class PrinterDetailStateInitial extends PrinterDetailState {}

class PrinterDetailStateLoadingDevices extends PrinterDetailState {}

class PrinterDetailStateLoadedDevices extends PrinterDetailState {}

class PrinterDetailStateOnSelectWifi extends PrinterDetailState {}

class PrinterDetailStateOnSelectBluetooth extends PrinterDetailState {}

class PrinterDetailStateConnectedBluetooth extends PrinterDetailState {}

class PrinterDetailStateConnectedWifi extends PrinterDetailState {}

abstract class PrinterDetailStateSavedDefaultDevice extends PrinterDetailState {
}

class PrinterDetailStateSavedDefaultDeviceBluetooth
    extends PrinterDetailStateSavedDefaultDevice {}

class PrinterDetailStateSavedDefaultDeviceWifi
    extends PrinterDetailStateSavedDefaultDevice {}

class PrinterDetailStateOnSelectingDevice extends PrinterDetailState {}

class PrinterDetailStateOnNoSelectingDevice extends PrinterDetailState {}

class PrinterDetailStateBluetoothNotEnable extends PrinterDetailState {}

class PrinterDetailStateBluetoothCheckingEnable extends PrinterDetailState {}

class PrinterDetailStateBluetoothEnable extends PrinterDetailState {}
