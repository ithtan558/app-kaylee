part of '../base/printer_detail_base.dart';

abstract class PrinterDetailState {}

class PrinterDetailStateInitial extends PrinterDetailState {}

class PrinterDetailStateLoadingDevices extends PrinterDetailState {}

class PrinterDetailStateLoadedDevices extends PrinterDetailState {}

class PrinterDetailStateOnSelectWifi extends PrinterDetailState {}

class PrinterDetailStateOnSelectBluetooth extends PrinterDetailState {}

class PrinterDetailStateConnectedWifi extends PrinterDetailState {}

abstract class PrinterDetailStateSavedDefaultDevice extends PrinterDetailState {
}

class PrinterDetailStateSavedDefaultDeviceWifi
    extends PrinterDetailStateSavedDefaultDevice {}

class PrinterDetailStateSavedDefaultDeviceBluetooth
    extends PrinterDetailStateSavedDefaultDevice {}

class PrinterDetailStateOnSelectingDevice extends PrinterDetailState {}

class PrinterDetailStateOnNoSelectingDevice extends PrinterDetailState {}

class PrinterDetailStateBluetoothNotEnable extends PrinterDetailState {}

class PrinterDetailStateBluetoothCheckingEnable extends PrinterDetailState {}

class PrinterDetailStateBluetoothEnable extends PrinterDetailState {}

///bắt đầu xử lý connect bluetooth printer
class PrinterDetailStateStartingConnectBluetoothDeviceProcess
    extends PrinterDetailState {}

///kết thúc xử lý connect bluetooth printer
class PrinterDetailStateEndingConnectBluetoothDeviceProcess
    extends PrinterDetailState {}

///gọi connect tới bluetooth printer mới
class PrinterDetailStateRequestingConnectBluetooth extends PrinterDetailState {}

///trạng thái đã connect tới bluetooth printer mới
class PrinterDetailStateConnectedBluetooth extends PrinterDetailState {}

///gọi disconnect tới bluetooth printer hiện tại
class PrinterDetailStateRequestingDisconnectBluetooth
    extends PrinterDetailState {}

///trạng thái đã disconnect tới bluetooth printer hiện tại
class PrinterDetailStateDisconnectBluetooth extends PrinterDetailState {}

class PrinterDetailStatePrintingConnectionInfo extends PrinterDetailState {}

class PrinterDetailStateFinishPrintingConnectionInfo
    extends PrinterDetailState {}

class PrinterDetailStateCannotConnectBluetoothDevice
    extends PrinterDetailState {}

class PrinterDetailStateRemovingConnectionBluetoothDevice
    extends PrinterDetailState {}

class PrinterDetailStateRemovedConnectionBluetoothDevice
    extends PrinterDetailState {}

class PrinterDetailStateLostConnectionBluetoothDevice
    extends PrinterDetailState {}