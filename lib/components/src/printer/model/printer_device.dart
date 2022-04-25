import 'package:anth_package/anth_package.dart';

class PrinterDevice {
  ///for wifi device
  final String? ip;
  final int? port;

  bool get isWifi => ip != null;

  ///for bluetooth device
  final String? name;
  final String? address;
  final int? type;

  bool selected;

  bool get isBluetooth => address.isNotNull;

  String get deviceName => isWifi
      ? '$ip - Wifi'
      : isBluetooth
          ? '$name - Bluetooth'
          : '';

  String? get deviceAddress => isWifi
      ? ip
      : isBluetooth
          ? address
          : '';

  bool isEqual(PrinterDevice device) {
    if (isWifi) {
      return device.ip == ip;
    } else if (isBluetooth) {
      return device.address == address;
    }
    return false;
  }

  PrinterDevice(
      {this.ip,
      this.port = 9100,
      this.name,
      this.address,
      this.type,
      this.selected = false});

  factory PrinterDevice.wifi({required String ip, int port = 9100}) =>
      PrinterDevice(ip: ip, port: port);

  factory PrinterDevice.bluetooth(
          {String? name, String? address, int? type = 0}) =>
      PrinterDevice(name: name, address: address, type: type);

  factory PrinterDevice.fromJson(json) => PrinterDevice(
        ip: json['ip'] as String,
        port: json['port'] as int,
        name: json['name'] as String? ?? '',
        address: json['address'] as String? ?? '',
        type: json['type'] as int? ?? -1,
        selected: json['selected'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'port': port,
        'name': name,
        'address': address,
        'type': type,
        'selected': selected,
      };
}
