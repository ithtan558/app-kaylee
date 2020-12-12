import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class PrinterDetailScreen extends StatefulWidget {
  static Widget newInstance() => PrinterDetailScreen._();

  PrinterDetailScreen._();

  @override
  _PrinterDetailScreenState createState() => _PrinterDetailScreenState();
}

class _PrinterDetailScreenState extends KayleeState<PrinterDetailScreen> {
  final _ipTFController = TextEditingController();

  @override
  void initState() {
    super.initState();
    PrinterModule.init();
    _ipTFController.text = PrinterModule.getPrinterDevice().ip;
  }

  @override
  void dispose() {
    _ipTFController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          title: Strings.caiDatMayIn,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.px16, vertical: Dimens.px16),
              child: KayleeTextField.normal(
                controller: _ipTFController,
                maxLength: 15,
                title: Strings.diaChiIp,
                hint: Strings.ipHint,
              ),
            )
          ],
        ),
        bottom: KayLeeRoundedButton.normal(
          text: Strings.luu,
          margin: const EdgeInsets.symmetric(horizontal: Dimens.px16)
              .copyWith(bottom: Dimens.px16),
          onPressed: () async {
            final device = PrinterDevice(
              ip: _ipTFController.text,
            );
            PrinterModule.savePrinterDevice(device: device);
            tryToConnectPrinterDevice(context: context, device: device);
          },
        ),
      ),
    );
  }

  void tryToConnectPrinterDevice(
      {BuildContext context, PrinterDevice device}) async {
    showLoading();
    final connected = await PrinterModule.connect(device: device);
    if (connected) {
      await PrinterModule.printConnectionInfo();
      hideLoading();
      showKayleeAlertMessageYesDialog(
        context: context,
        message: Message(content: Strings.luuThanhCong),
        onPressed: popScreen,
      );
    } else {
      hideLoading();
      showKayleeDialogNotAbleToConnectPrinter(
        context: context,
        onTryAgain: () async {
          await PrinterModule.disconnect();
          tryToConnectPrinterDevice(context: context, device: device);
        },
      );
    }
  }
}
