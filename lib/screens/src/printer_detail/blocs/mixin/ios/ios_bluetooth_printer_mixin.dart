part of '../../base/printer_detail_base.dart';

mixin IosBluetoothPrinterMixin on BluetoothPrinterMixin {
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
      print('[TUNG] ===> _initBluetoothStateListener cur device status: '
          '${state == BluetoothPrint.CONNECTED ? 'Connected' : state == BluetoothPrint.DISCONNECTED ? 'Disconnected' : state}');
      switch (state) {
        case BluetoothPrint.CONNECTED:
          BluetoothPrinterModule.connected = true;
          _stopRequestDisconnectingTimeOut();
          _stopRequestConnectingTimeOut();
          print('[TUNG] ===> before connectedBluetoothDevice ${this.state}');
          _stateChanges = state;
          return connectedBluetoothDevice();
        case BluetoothPrint.DISCONNECTED:
          BluetoothPrinterModule.connected = false;
          if (_stateChanges == BluetoothPrint.CONNECTED) return;
          print(
              '[TUNG] ===> before PrinterDetailStateRequestingDisconnectBluetooth requestConnectingBluetoothDevice ${this.state}');
          _stateChanges = state;
          if (this.state is PrinterDetailStateRequestingDisconnectBluetooth) {
            _stopRequestDisconnectingTimeOut();
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
    if (_startConnectTime.isNotNull) {
      emit(PrinterDetailStateConnectedBluetooth());
    }
    _startConnectTime = null;
  }

  DateTime? _startConnectTime;

  @override
  void startConnectingBluetoothDevice() async {
    _startConnectTime = DateTime.now();
    _stateChanges = -1;
    emit(PrinterDetailStateStartingConnectBluetoothDeviceProcess());
    if (BluetoothPrinterModule.connected) {
      return requestDisconnectingBluetoothDevice();
    }
    requestConnectingBluetoothDevice();
  }

  void requestConnectingBluetoothDevice() async {
    _stateChanges = -1;
    emit(PrinterDetailStateRequestingConnectBluetooth());
    print('[TUNG] ===> requestConnectingBluetoothDevice start');
    try {
      final result = await connect();
      print('[TUNG] ===> requestConnectingBluetoothDevice result $result');
    } catch (e) {}
    _startRequestConnectingTimeOut();
  }

  Timer? _requestConnectingTimeOut;

  void _startRequestConnectingTimeOut() {
    if (_requestConnectingTimeOut != null &&
        _requestConnectingTimeOut!.isActive) {
      _stopRequestConnectingTimeOut();
    }
    _requestConnectingTimeOut =
        Timer.periodic(Duration(seconds: 1), (timer) async {
      print('[TUNG] ===> _requestConnectingTimeOut ${timer.tick}');
      if (timer.tick == 6) {
        if (state is! PrinterDetailStateConnectedBluetooth &&
            state is! PrinterDetailStatePrintingConnectionInfo &&
            state is! PrinterDetailStateFinishPrintingConnectionInfo) {
          if (BluetoothPrinterModule.connected) {
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

  Timer? _requestDisconnectingTimeOut;

  void _startRequestDisconnectingTimeOut() {
    if (_requestDisconnectingTimeOut != null &&
        _requestDisconnectingTimeOut!.isActive) {
      _stopRequestConnectingTimeOut();
    }
    _requestDisconnectingTimeOut =
        Timer.periodic(Duration(seconds: 1), (timer) async {
      print('[TUNG] ===> _requestDisconnectingTimeOut ${timer.tick}');
      if (timer.tick == 6) {
        if (BluetoothPrinterModule.connected) {
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
    final result = await connect();
    print('[TUNG] ===> requestDisconnectingBluetoothDevice result $result');
    _startRequestDisconnectingTimeOut();
  }

  @override
  Future<void> close() async {
    _stopRequestConnectingTimeOut();
    _stopRequestDisconnectingTimeOut();
    return super.close();
  }
}
