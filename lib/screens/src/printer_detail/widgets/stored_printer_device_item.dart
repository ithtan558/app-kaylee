import 'package:anth_package/anth_package.dart' hide VoidCallback;
import 'package:flutter/material.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/printer_detail/widgets/printer_device_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class StoredPrinterDeviceItem extends StatelessWidget {
  final PrinterDevice device;
  final VoidCallback onTap;
  final VoidCallback onRemoveItem;

  StoredPrinterDeviceItem({
    this.device,
    this.onTap,
    this.onRemoveItem,
  }) : super(key: ValueKey(device.deviceAddress));

  @override
  Widget build(BuildContext context) {
    return KayleeDismissible.iconOnly(
      key: ValueKey(device.deviceAddress),
      onDismissed: (direction) => onRemoveItem?.call,
      confirmDismiss: () async {
        final result = await showKayleeAlertDialog(
            context: context,
            view: KayleeAlertDialogView(
                title: Strings.banSeXoaPrinter,
                content: Strings.printerBiXoaMatKhoiThietBi,
                actions: [
                  KayleeAlertDialogAction.dongY(
                    onPressed: () {
                      context.pop(resultBundle: Bundle(true));
                    },
                    isDefaultAction: true,
                  ),
                  KayleeAlertDialogAction.huy(
                    onPressed: () {
                      context.pop(resultBundle: Bundle(false));
                    },
                  ),
                ]));

        return (result as Bundle)?.args ?? false;
      },
      child: PrinterDeviceItem(
        device: device,
        onTap: onTap,
      ),
    );
  }
}
