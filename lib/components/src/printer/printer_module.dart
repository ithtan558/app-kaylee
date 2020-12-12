import 'dart:convert';

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

  static PrinterDevice getPrinterDevice() {
    final fromSharePref = SharedRef.getString(PRINTER_DEVICE_KEY);
    final map = Map<String, dynamic>.from(
        jsonDecode(fromSharePref.isNullOrEmpty ? '{}' : fromSharePref));
    if (map.isEmpty) return PrinterDevice();
    return PrinterDevice.fromJson(map);
  }

  static void savePrinterDevice({PrinterDevice device}) {
    SharedRef.putString(PRINTER_DEVICE_KEY, jsonEncode(device.toJson()));
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
      savePrinterDevice(device: device);
      return true;
    }
    return false;
  }

  static Future<void> printConnectionInfo() async {
    if (_printer.isNull) return;
    final device = getPrinterDevice();
    if (device.isNull) {
      await disconnect();
      return;
    }
    _printer.text('Connected ${device.ip}:${device.port}');
    _printer.cut();
    await disconnect();
  }

  static void printOrder({Order order, Image billImage}) async {
    if (order.isNull) return;
    if (_printer.isNull) return;
    // final dio = Dio();
    // final uri = Uri.parse(order.brand.logo);
    // var tempDir = await getTemporaryDirectory();
    // File logoFile = File(tempDir.path + uri.pathSegments.last);
    // if (!logoFile.existsSync()) {
    //   await dio.download(
    //     uri.toString(),
    //     '${tempDir.path}${uri.pathSegments.last}',
    //   );
    // }
    // _printer.imageRaster(
    //     copyResize(decodeImage(logoFile.readAsBytesSync()),
    //         width: 200, height: 200),
    //     imageFn: PosImageFn.bitImageRaster);
    _printer.imageRaster(billImage, imageFn: PosImageFn.bitImageRaster);
    _printer.cut();
    await disconnect();
  }

  static Future<void> disconnect() async {
    _printer?.disconnect();
  }

  static Future<void> connectPrinter(BuildContext context,
      {Order order, ValueChanged<bool> loading, Image image}) async {
    await init();
    await getGenerator();

    final device = getPrinterDevice();
    String ip = device?.ip;
    if (device.isNull) {
      await showKayleeAlertDialog(
          context: context,
          view: KayleeAlertDialogView(
            title: Strings.ketNoiVoiMayIn,
            contentWidget: Padding(
              padding: const EdgeInsets.only(top: Dimens.px8),
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(Dimens.px5),
                child: KayleeTextField.normal(
                  hint: Strings.ipHint,
                  controller: TextEditingController(),
                  maxLength: 15,
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
      printOrder(order: order, billImage: image);
    } else {
      loading?.call(false);
      showKayleeDialogNotAbleToConnectPrinter(
        context: context,
        onTryAgain: () {
          disconnect();
          connectPrinter(context, order: order, loading: loading, image: image);
        },
      );
    }
  }
}

Future<void> showKayleeDialogNotAbleToConnectPrinter(
    {BuildContext context, VoidCallback onTryAgain}) {
  return showKayleeAlertDialog(
    context: context,
    view: KayleeAlertDialogView(
      content: Strings.khongTheKetNoiVoiPrinter,
      actions: [
        KayleeAlertDialogAction.huy(
          onPressed: () {
            context.pop();
          },
        ),
        KayleeAlertDialogAction(
          title: Strings.thuLai,
          onPressed: () {
            onTryAgain?.call();
            context.pop();
          },
          isDefaultAction: true,
        ),
      ],
    ),
  );
}
