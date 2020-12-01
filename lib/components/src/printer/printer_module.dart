import 'dart:convert';
import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:image/image.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/utils/utils.dart';

const String PRINTER_DEVICE_KEY = 'PRINTER_DEVICE';

class PrinterDevice {
  final String ip;
  final int port;

  PrinterDevice({this.ip, this.port = 9100});

  factory PrinterDevice.fromJson(json) => PrinterDevice(
        ip: json['ip'] as String,
        port: json['port'] as int,
      );

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'port': port,
      };
}

class PrinterModule {
  static NetworkPrinter _printer;
  static Generator _generator;
  static CapabilityProfile _profile;

  static Future<void> init() async {
    if (_printer.isNotNull) return;
    final paper = PaperSize.mm80;
    _profile = await CapabilityProfile.load(name: 'XP-N160I');
    _printer = NetworkPrinter(paper, _profile);
  }

  static Future<Generator> getGenerator() async {
    if (_generator.isNull) {
      _generator = Generator(PaperSize.mm80, _profile);
    }
    return _generator;
  }

  static Future<bool> connect({PrinterDevice device}) async {
    final PosPrintResult res =
    await _printer?.connect(device?.ip, port: device?.port);
    if (res == PosPrintResult.success) {
      SharedRef.putString(PRINTER_DEVICE_KEY, jsonEncode(device.toJson()));
      return true;
    } else if (res == PosPrintResult.timeout) {
      disconnect();
      return connect(device: device);
    }
    return false;
  }

  static void printOrder({Order order}) async {
    if (order.isNull) return;
    if (_printer.isNull) return;
    final dio = Dio();

    final uri = Uri.parse(order.brand.logo);
    var tempDir = await getTemporaryDirectory();
    File file = File(tempDir.path + uri.pathSegments.last);
    if (!file.existsSync()) {
      await dio.download(
        uri.toString(),
        '${tempDir.path}${uri.pathSegments.last}',
      );
    }

    final image = copyResize(decodeImage(file.readAsBytesSync()),
        width: 200, height: 200);
    _printer.imageRaster(image, imageFn: PosImageFn.bitImageRaster);
    _printer.text('');
    _printer.text('DC: ${order.brand.location}',
        styles: PosStyles(
          align: PosAlign.center,
        ),
        linesAfter: 1);
    _printer.text('DT: ${order.brand.phone}',
        styles: PosStyles(
          align: PosAlign.center,
        ),
        linesAfter: 1);
    _printer.text('Hoá đơn bán hàng'.removeVnAccent(),
        styles: PosStyles(
          align: PosAlign.center,
          width: PosTextSize.size1,
          height: PosTextSize.size1,
          bold: true,
        ),
        linesAfter: 1);
    _printer.row([
      PosColumn(
        width: 6,
        text: 'Ngày: ${order.createdAt.toFormatString(pattern: dateFormat2)}'
            .removeVnAccent(),
        styles: PosStyles(
          align: PosAlign.left,
        ),
      ),
      PosColumn(
        text: 'Số: ${order.code}'.removeVnAccent(),
        width: 6,
        styles: PosStyles(
          align: PosAlign.right,
        ),
      ),
    ]);
    _printer.text(
      'Khách hàng: ${order.customer.fullName}'.removeVnAccent(),
    );
    _printer.text('Nhân viên: ${order.employee.name}'.removeVnAccent(),
        linesAfter: 1);

    _printer.row([
      PosColumn(
        text: 'Mặt hàng'.removeVnAccent(),
        width: 4,
        styles: PosStyles(
          bold: true,
        ),
      ),
      PosColumn(
        text: 'SL',
        styles: PosStyles(
          bold: true,
          align: PosAlign.right,
        ),
      ),
      PosColumn(
        text: 'Giá'.removeVnAccent(),
        width: 3,
        styles: PosStyles(
          bold: true,
          align: PosAlign.right,
        ),
      ),
      PosColumn(
        text: 'T tiền'.removeVnAccent(),
        width: 3,
        styles: PosStyles(
          bold: true,
          align: PosAlign.right,
        ),
      ),
    ]);

    order.orderItems.forEach((product) {
      _printer.row([
        PosColumn(
            text: product.name.removeVnAccent(), width: 4, styles: PosStyles()),
        PosColumn(
          text: product.quantity.toString(),
          styles: PosStyles(
            align: PosAlign.right,
          ),
        ),
        PosColumn(
          text: CurrencyUtils.formatVNDWithCustomUnit(product.price),
          width: 3,
          styles: PosStyles(
            align: PosAlign.right,
          ),
        ),
        PosColumn(
          text: CurrencyUtils.formatVNDWithCustomUnit(product.total),
          width: 3,
          styles: PosStyles(
            align: PosAlign.right,
          ),
        ),
      ]);
    });
    _printer.text('');
    _printer.row(
      [
        PosColumn(
          text: 'Tổng:'.removeVnAccent(),
          width: 6,
          styles: PosStyles(
            bold: true,
          ),
        ),
        PosColumn(
          text: CurrencyUtils.formatVNDWithCustomUnit(order.total),
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
          ),
        ),
      ],
    );
    _printer.row(
      [
        PosColumn(
          text: 'Giảm giá:'.removeVnAccent(),
          width: 6,
          styles: PosStyles(
            bold: true,
          ),
        ),
        PosColumn(
          text: CurrencyUtils.formatVNDWithCustomUnit(order.discount ?? 0),
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
          ),
        ),
      ],
    );
    _printer.row(
      [
        PosColumn(
            text: 'Thành tiền:'.removeVnAccent(),
            width: 6,
            styles: PosStyles(
              bold: true,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
        PosColumn(
            text: CurrencyUtils.formatVNDWithCustomUnit(order.amount),
            width: 6,
            styles: PosStyles(
              bold: true,
              align: PosAlign.right,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
      ],
    );

    _printer.text('\nCảm ơn quý khách. Hẹn gặp lại!'.removeVnAccent(),
        styles: PosStyles(
          align: PosAlign.center,
        ));
    _printer.feed(2);
    _printer.cut();
    await disconnect();
  }

  static Future<void> disconnect() async {
    _printer?.disconnect();
  }
}
