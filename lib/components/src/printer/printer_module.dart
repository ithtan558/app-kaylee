import 'dart:convert';
import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';
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
    _profile = await CapabilityProfile.load();
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
    }
    return false;
  }

  static void printOrder({Order order, Image image}) async {
    if (order.isNull) return;
    if (_printer.isNull) return;
    final dio = Dio();
    print('[TUNG] ===> pngBytes $image');
    final uri = Uri.parse(order.brand.logo);
    var tempDir = await getTemporaryDirectory();
    File file = File(tempDir.path + uri.pathSegments.last);
    // if (!file.existsSync()) {
    //   await dio.download(
    //     uri.toString(),
    //     '${tempDir.path}${uri.pathSegments.last}',
    //   );
    // }

    // file.writeAsBytesSync(pngBytes.toList());
    // //
    // var image = image;
    print('[TUNG] ===> ${image?.width}');
    image = copyResize(image, width: image.width);
    _printer.imageRaster(image, imageFn: PosImageFn.bitImageRaster);
    // _printer.text('');
    // List<String> charsets = await CharsetConverter.availableCharsets();

    //  charsets.forEach((charset) async {
    //   await CharsetConverter.encode(
    //           charset, 'ă')
    //       .then((encode) {
    //    print('[TUNG] ===> $charset ${encode}');
    //   });
    // });

    // var map = {};
    // // print(
    // //     '[TUNG] ===> ${hex.encode('a,b,c,d,e,f,g,h,i,k,l,m,n,o,p,q,r,s,t,u,v,x,y'.codeUnits)}');
    // 'á,à,ả,ã,ạ,â,ấ,ầ,ẩ,ẫ,ậ,ă,ắ,ằ,ẳ,ẵ,ặ,đ,é,è,ẻ,ẽ,ẹ,ê,ế,ề,ể,ễ,ệ,í,ì,ỉ,ĩ,ị,ó,ò,ỏ,õ,ọ,ô,ố,ồ,ổ,ỗ,ộ,ơ,ớ,ờ,ở,ỡ,ợ,ú,ù,ủ,ũ,ụ,ư,ứ,ừ,ử,ữ,ự,ý,ỳ,ỷ,ỹ,ỵ'
    //     .toUpperCase()
    //     .split(',')
    //     .forEach((element) {
    //   map.putIfAbsent('\"$element\"', () => '0x' + '1');
    // });
    //   _printer.textEncoded(Uint8List.fromList([0x00C0]),styles: PosStyles(
    //   ),linesAfter: -1);
    // _printer.textEncoded(Uint8List.fromList([0xA0]),styles: PosStyles(
    // ),linesAfter: -1);
    // print('[TUNG] ===> ${map}');
    // _printer.setGlobalCodeTable('CP1251');
    // _printer.textEncoded(await CharsetConverter.encode('windows-1258', 'ắ'));
    // for (var element in _profile.codePages) {
    //   _printer.textEncoded(await CharsetConverter.encode('iso-8859-1', 'Ă'),
    //       styles: PosStyles(
    //         codeTable: element.name,
    //       ));
    // }
    // _profile.codePages.forEach((element) {
    //   _printer.textEncoded(Uint8List.fromList([0xD0]),
    //       styles: PosStyles(
    //         codeTable: element.name,
    //       ),
    //       linesAfter: -1);
    // });
    _printer.cut();
    await disconnect();
    // List<String> charsets = await CharsetConverter.availableCharsets();
    // await charsets.forEach((charset) async {
    //    await  CharsetConverter.encode(
    //       charset, '$charset ĐC: ${order.brand.location}').then((encode) {
    //       _printer.textEncoded(
    //         encode,
    //         styles: PosStyles(
    //           align: PosAlign.center,
    //         ),
    //       );
    //     });
    //
    // });

    // _printer.text('ĐT: ${order.brand.phone}'.removeVnAccent(),
    //     styles: PosStyles(
    //       align: PosAlign.center,
    //     ),
    //     linesAfter: 1);
    // _printer.text('Hoá đơn bán hàng'.toUpperCase().removeVnAccent(),
    //     styles: PosStyles(
    //       align: PosAlign.center,
    //       width: PosTextSize.size1,
    //       height: PosTextSize.size1,
    //       bold: true,
    //     ),
    //     linesAfter: 1);
    // _printer.row([
    //   PosColumn(
    //     width: 4,
    //     text: 'Ngày: ${order.createdAt.toFormatString(pattern: dateFormat2)}'
    //         .removeVnAccent()
    //         .trim(),
    //     styles: PosStyles(
    //       align: PosAlign.left,
    //     ),
    //   ),
    //   PosColumn(
    //     width: 4,
    //     text: '',
    //     styles: PosStyles(
    //       align: PosAlign.left,
    //     ),
    //   ),
    //   PosColumn(
    //     text: 'Số: ${order.code}'.removeVnAccent(),
    //     width: 4,
    //     styles: PosStyles(
    //       align: PosAlign.left,
    //     ),
    //   ),
    // ]);
    // _printer.text('Khách hàng: ${order.customer.fullName}'.removeVnAccent());
    // _printer.text('Nhân viên: ${order.employee.name}'.removeVnAccent(),
    //     linesAfter: 1);
    //
    // _printer.hr();
    // _printer.row([
    //   PosColumn(
    //     text: 'SL'.removeVnAccent(),
    //     width: 3,
    //     styles: PosStyles(
    //       bold: true,
    //       align: PosAlign.right,
    //     ),
    //   ),
    //   PosColumn(
    //     text: 'Giá'.removeVnAccent(),
    //     width: 4,
    //     styles: PosStyles(
    //       bold: true,
    //       align: PosAlign.right,
    //     ),
    //   ),
    //   PosColumn(
    //     text: 'T tiền'.removeVnAccent(),
    //     width: 5,
    //     styles: PosStyles(
    //       bold: true,
    //       align: PosAlign.right,
    //     ),
    //   ),
    // ]);
    // _printer.hr();
    // order.orderItems.forEach((product) {
    //   _printer.text(product.name.removeVnAccent());
    //   _printer.row([
    //     PosColumn(
    //       text: product.quantity.toString(),
    //       width: 3,
    //       styles: PosStyles(
    //         align: PosAlign.right,
    //       ),
    //     ),
    //     PosColumn(
    //       text: CurrencyUtils.formatVNDWithCustomUnit(product.price),
    //       width: 4,
    //       styles: PosStyles(
    //         align: PosAlign.right,
    //       ),
    //     ),
    //     PosColumn(
    //       text: CurrencyUtils.formatVNDWithCustomUnit(product.total),
    //       width: 5,
    //       styles: PosStyles(
    //         align: PosAlign.right,
    //       ),
    //     ),
    //   ]);
    //   _printer.emptyLines(1);
    // });
    // _printer.hr();
    // _printer.text('');
    // _printer.row(
    //   [
    //     PosColumn(
    //       text: 'Tổng:'.removeVnAccent(),
    //       width: 6,
    //       styles: PosStyles(
    //         bold: true,
    //       ),
    //     ),
    //     PosColumn(
    //       text: CurrencyUtils.formatVNDWithCustomUnit(order.total),
    //       width: 6,
    //       styles: PosStyles(
    //         align: PosAlign.right,
    //       ),
    //     ),
    //   ],
    // );
    // _printer.row(
    //   [
    //     PosColumn(
    //       text: 'Giảm giá:'.removeVnAccent(),
    //       width: 6,
    //       styles: PosStyles(
    //         bold: true,
    //       ),
    //     ),
    //     PosColumn(
    //       text: CurrencyUtils.formatVNDWithCustomUnit(order.discount ?? 0),
    //       width: 6,
    //       styles: PosStyles(
    //         align: PosAlign.right,
    //       ),
    //     ),
    //   ],
    // );
    // _printer.row(
    //   [
    //     PosColumn(
    //         text: 'Thành tiền:'.removeVnAccent(),
    //         width: 6,
    //         styles: PosStyles(
    //           bold: true,
    //           height: PosTextSize.size2,
    //           width: PosTextSize.size2,
    //         )),
    //     PosColumn(
    //         text: CurrencyUtils.formatVNDWithCustomUnit(order.amount),
    //         width: 6,
    //         styles: PosStyles(
    //           bold: true,
    //           align: PosAlign.right,
    //           height: PosTextSize.size2,
    //           width: PosTextSize.size2,
    //         )),
    //   ],
    // );

    // _printer.text('\nCảm ơn quý khách. Hẹn gặp lại!'.removeVnAccent(),
    //     styles: PosStyles(
    //       align: PosAlign.center,
    //     ));
    // _printer.cut();
    // await disconnect();
  }

  static Future<void> disconnect() async {
    _printer?.disconnect();
  }

  static Future<void> connectPrinter(BuildContext context,
      {Order order, ValueChanged<bool> loading, Image image}) async {
    await init();
    await getGenerator();

    final fromSharePref = SharedRef.getString(PRINTER_DEVICE_KEY);
    final map = Map<String, dynamic>.from(
        jsonDecode(fromSharePref.isNullOrEmpty ? '{}' : fromSharePref));
    String ip = PrinterDevice
        .fromJson(map)
        .ip;
    if (map.isEmpty) {
      await showKayleeAlertDialog(
          context: context,
          view: KayleeAlertDialogView(
            title: 'Kết nối với máy in!',
            contentWidget: Padding(
              padding: const EdgeInsets.only(top: Dimens.px8),
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(Dimens.px5),
                child: KayleeTextField.normal(
                  hint: '192.168.1.123',
                  controller: TextEditingController(),
                  onChanged: (value) {
                    ip = value;
                  },
                ),
              ),
            ),
            actions: [
              KayleeAlertDialogAction.huy(
                onPressed: context.pop,
              ),
              KayleeAlertDialogAction(
                title: Strings.luu,
                isDefaultAction: true,
                onPressed: context.pop,
              ),
            ],
          ));
      if (ip.isNullOrEmpty) {
        return;
      }
    }

    loading?.call(true);
    if (await connect(device: PrinterDevice(ip: ip))) {
      loading?.call(false);
      printOrder(order: order, image: image);
    } else {
      loading?.call(false);
      showKayleeAlertDialog(
          context: context,
          view: KayleeAlertDialogView(
            content: 'Không thể kết nối tới máy in',
            actions: [
              KayleeAlertDialogAction.huy(
                onPressed: () {
                  context.pop();
                },
              ),
              KayleeAlertDialogAction(
                title: 'Thử lại',
                onPressed: () {
                  disconnect();
                  connectPrinter(context,
                      order: order, loading: loading, image: image);
                  context.pop();
                },
                isDefaultAction: true,
              ),
            ],
          ));
    }
  }
}
