part of '../../base/printer_detail_base.dart';

mixin IosBluetoothPrinterMixin on BluetoothPrinterMixin {
  StreamSubscription _bluetoothSub;

  @override
  void init() {
    _initBluetoothStateListener();
  }

  ///-1: start
  ///1: connected
  ///0: disconnected
  int _stateChanges = -1;

  void _initBluetoothStateListener() {
    _bluetoothSub = BluetoothPrint.instance.state.listen((state) async {
      print('cur device status: $state');
      switch (state) {
        case BluetoothPrint.CONNECTED:
          if (!BluetoothPrinterModule.connected) {
            BluetoothPrinterModule.connected =
                !BluetoothPrinterModule.connected;
          }
          _stopRequestDisconnectingTimeOut();
          _stopRequestConnectingTimeOut();
          print('[TUNG] ===> before connectedBluetoothDevice ${this.state}');
          _stateChanges = state;
          return connectedBluetoothDevice();
        case BluetoothPrint.DISCONNECTED:
          if (BluetoothPrinterModule.connected) {
            BluetoothPrinterModule.connected =
                !BluetoothPrinterModule.connected;
          }
          if (_stateChanges == BluetoothPrint.CONNECTED) return;
          print(
              '[TUNG] ===> before PrinterDetailStateRequestingDisconnectBluetooth requestConnectingBluetoothDevice ${this.state}');
          _stateChanges = state;
          if (this.state is PrinterDetailStateRequestingDisconnectBluetooth) {
            _stopRequestDisconnectingTimeOut();
            // await Future.delayed(Duration(seconds: 2), () {});
            emit(PrinterDetailStateDisconnectBluetooth());
            print(
                '[TUNG] ===> PrinterDetailStateRequestingDisconnectBluetooth requestConnectingBluetoothDevice');
            return requestConnectingBluetoothDevice();
          }
          return;
        default:
          break;
      }
    });
  }

  void connectedBluetoothDevice() async {
    await Future.delayed(Duration(seconds: 2));
    emit(PrinterDetailStateConnectedBluetooth());
  }

  @override
  void startConnectingBluetoothDevice() async {
    _stateChanges = -1;
    emit(PrinterDetailStateStartingConnectBluetoothDeviceProcess());
    if (await BluetoothPrint.instance.isConnected) {
      return requestDisconnectingBluetoothDevice();
    }
    requestConnectingBluetoothDevice();
  }

  void requestConnectingBluetoothDevice() async {
    _stateChanges = -1;
    emit(PrinterDetailStateRequestingConnectBluetooth());
    print('[TUNG] ===> requestConnectingBluetoothDevice start');
    try {
      final result = await BluetoothPrint.instance
          .connect(BluetoothDevice.fromJson(connectedDevice.toJson()));
      print('[TUNG] ===> requestConnectingBluetoothDevice result $result');
    } catch (e) {}
    _startRequestConnectingTimeOut();
  }

  Timer _requestConnectingTimeOut;

  void _startRequestConnectingTimeOut() {
    if (_requestConnectingTimeOut.isNotNull &&
        _requestConnectingTimeOut.isActive) {
      _stopRequestConnectingTimeOut();
    }
    _requestConnectingTimeOut =
        Timer.periodic(Duration(seconds: 1), (timer) async {
      print('[TUNG] ===> _requestConnectingTimeOut ${timer.tick}');
      if (timer.tick == 6) {
        if (state is! PrinterDetailStateConnectedBluetooth &&
            state is! PrinterDetailStatePrintingConnectionInfo &&
            state is! PrinterDetailStateFinishPrintingConnectionInfo) {
          if (await BluetoothPrint.instance.isConnected) {
            return connectedBluetoothDevice();
          }
          return _showCannotConnectBluetoothDevice();
        }
      }
      if (timer.tick > 6) {
        timer.cancel();
      }
    });
  }

  void _stopRequestConnectingTimeOut() {
    _requestConnectingTimeOut?.cancel();
  }

  void _showCannotConnectBluetoothDevice() {
    emit(PrinterDetailStateCannotConnectBluetoothDevice());
  }

  Timer _requestDisconnectingTimeOut;

  void _startRequestDisconnectingTimeOut() {
    if (_requestDisconnectingTimeOut.isNotNull &&
        _requestDisconnectingTimeOut.isActive) {
      _stopRequestConnectingTimeOut();
    }
    _requestDisconnectingTimeOut =
        Timer.periodic(Duration(seconds: 1), (timer) async {
      print('[TUNG] ===> _requestDisconnectingTimeOut ${timer.tick}');
      if (timer.tick == 6) {
        if (await BluetoothPrint.instance.isConnected) {
          return connectedBluetoothDevice();
        }
        if (state is PrinterDetailStateRequestingDisconnectBluetooth) {
          return _showCannotConnectBluetoothDevice();
        }
      }
      if (timer.tick > 6) {
        timer.cancel();
      }
    });
  }

  void _stopRequestDisconnectingTimeOut() {
    _requestDisconnectingTimeOut?.cancel();
  }

  void requestDisconnectingBluetoothDevice() async {
    emit(PrinterDetailStateRequestingDisconnectBluetooth());
    final result =
        await BluetoothPrinterModule.connect(device: connectedDevice);
    print('[TUNG] ===> requestDisconnectingBluetoothDevice result $result');
    _startRequestDisconnectingTimeOut();
  }

  @override
  Future<void> close() async {
    _stopRequestConnectingTimeOut();
    _stopRequestDisconnectingTimeOut();
    await _bluetoothSub.cancel();
    return super.close();
  }
}
