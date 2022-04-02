import 'dart:convert';

import 'package:anth_package/anth_package.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';
import 'package:kaylee/components/src/printer/model/printer_device.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

const String printerDevicesKey = 'PRINTER_DEVICES_KEY';
const String locationProminentDisclosureForAndroidKey =
    'LOCATION_PROMINENT_DISCLOSURE_FOR_ANDROID_KEY';

class PrinterModule {
  static late NetworkPrinter _printer;
  static late CapabilityProfile _profile;

  static Future<void> init() async {
    final paper = PaperSize.mm80;
    _profile = await CapabilityProfile.load();
    _printer = NetworkPrinter(paper, _profile);
  }

  static Future<bool> connect({PrinterDevice? device}) async {
    if (device == null) return false;
    final PosPrintResult res =
        await _printer.connect(device.ip!, port: device.port!);
    if (res == PosPrintResult.success) {
      return true;
    }
    return false;
  }

  static Future<bool> printConnectionInfo({PrinterDevice? device}) async {
    final connected = await connect(device: device);
    if (connected) {
      _printer.text('Connected ${device!.ip}:${device.port}');
      _printer.cut();
      await disconnect();
      return true;
    }
    await disconnect();
    return false;
  }

  static void _printOrder({required Image billImage}) async {
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
    _printer.disconnect();
  }

  static Future<void> connectPrinter(BuildContext context,
      {required Order order,
      ValueChanged<bool>? loading,
      required Image image}) async {
    await init();

    final device = connectedDevice;

    loading?.call(true);

    final connected = await connect(device: device);
    if (connected) {
      loading?.call(false);
      _printOrder(billImage: image);
      return;
    } else {
      loading?.call(false);
      showKayleeDialogNotAbleToConnectPrinter(
        context: context,
        onTryAgain: () {
          disconnect();
          connectPrinter(context, order: order, loading: loading, image: image);
        },
      );
      return;
    }
  }

  static PrinterDevice get connectedDevice {
    final fromSharePref = SharedRef.getString(printerDevicesKey);
    final map = jsonDecode(fromSharePref == null || fromSharePref.isEmpty
        ? '[]'
        : fromSharePref) as List;
    final devices = map.map((e) => PrinterDevice.fromJson(e)).toList();
    final device = devices.firstWhere((element) => element.selected);
    return device;
  }
}

Future<void> showKayleeDialogNotAbleToConnectPrinter(
    {required BuildContext context, VoidCallback? onTryAgain}) {
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
            context.pop();
            onTryAgain?.call();
          },
          isDefaultAction: true,
        ),
      ],
    ),
  );
}

// Future<void> showPrinterSelectionDialog(
//     {BuildContext context, VoidCallback onSelectWifi, VoidCallback onSelectBluetooth})async{
//   return showKayleeAlertDialog(context: context,view: KayleeAlertDialogView(
//     content: Strings.chon,
//     actions: [
//       KayleeAlertDialogAction.huy(
//         onPressed: () {
//           context.pop();
//         },
//       ),
//       KayleeAlertDialogAction(
//         title: Strings.thuLai,
//         onPressed: () {
//           onTryAgain?.call();
//           context.pop();
//         },
//         isDefaultAction: true,
//       ),
//     ],
//   ),);
// }
