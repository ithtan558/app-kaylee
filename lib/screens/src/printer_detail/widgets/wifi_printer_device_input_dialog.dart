import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/res/res.dart';

class WifiPrinterDeviceInputDialog extends StatefulWidget {
  final ValueSetter<String> onSave;

  const WifiPrinterDeviceInputDialog({Key? key, required this.onSave})
      : super(key: key);

  @override
  _WifiPrinterDeviceInputDialogState createState() =>
      _WifiPrinterDeviceInputDialogState();
}

class _WifiPrinterDeviceInputDialogState
    extends KayleeState<WifiPrinterDeviceInputDialog> {
  final ipTfController = TextEditingController();

  @override
  void dispose() {
    ipTfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeAlertDialogView(
      title: Strings.ketNoiVoiMayIn,
      contentWidget: Padding(
        padding: const EdgeInsets.only(top: Dimens.px8),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(Dimens.px5),
          child: KayleeTextField.normal(
            hint: Strings.ipHint,
            controller: ipTfController,
            maxLength: 15,
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
          onPressed: () {
            widget.onSave.call(ipTfController.text);
            context.pop();
          },
        ),
      ],
    );
  }
}
