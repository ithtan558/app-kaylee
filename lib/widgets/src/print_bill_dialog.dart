import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart' hide TextStyle;
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/components/src/printer/bluetooth_printer_module.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintBillDialog extends StatefulWidget {
  final Order order;

  PrintBillDialog({this.order});

  @override
  _PrintBillDialogState createState() => _PrintBillDialogState();
}

class _PrintBillDialogState extends KayleeState<PrintBillDialog> {
  Order get _order => widget.order;
  PrinterDevice printerDevice;

  @override
  void initState() {
    super.initState();
    printerDevice = PrinterModule.connectedDevice;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<pw.Document>(
      future: (printerDevice?.isBluetooth ?? false)
          ? PdfModule.generateDocumentForOrderForRoll57(order: _order)
          : PdfModule.generateDocumentForOrder(order: _order),
      builder: (context, snapshot) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.px16, vertical: Dimens.px24),
              child: KayleeText.normal18W700(
                Strings.inLaiHoaDon,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Container(
                height: context.screenSize.height,
                child: snapshot.hasData
                    ? PdfPreview(
                        build: (format) => snapshot.data.save(),
                        useActions: false,
                      )
                    : null,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: ColorsRes.divider,
                width: Dimens.px1,
              ))),
              padding: const EdgeInsets.only(
                  left: Dimens.px8,
                  right: Dimens.px8,
                  top: Dimens.px16,
                  bottom: Dimens.px8),
              child: Row(
                children: [
                  Expanded(
                    child: KayLeeRoundedButton.button2(
                      margin: EdgeInsets.zero,
                      text: Strings.huyBo,
                      onPressed: popScreen,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayLeeRoundedButton.normal(
                      margin: EdgeInsets.zero,
                      text: Strings.In,
                      onPressed: () async {
                        if (snapshot.hasData) {
                          showLoading();
                          //print with wifi
                          if ((printerDevice?.isWifi ?? false)) {
                            return getPdfRasterForRol80(
                              data: snapshot.data.save(),
                              onPrint: (data) async {
                                await PrinterModule.connectPrinter(context,
                                    order: _order, image: data);
                                hideLoading();
                              },
                            );
                          }

                          //print with bluetooth
                          if ((printerDevice?.isBluetooth ?? false)) {
                            return getPdfRasterForRol57(
                              data: snapshot.data.save(),
                              onPrint: (data) async {
                                await BluetoothPrinterModule.print(data: data);
                                hideLoading();
                              },
                            );
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

Future<void> showKayleePrintOrderDialog({BuildContext context, Order order}) {
  return showKayleeDialog(
      context: context,
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px24)
          .copyWith(bottom: Dimens.px20),
      child: PrintBillDialog(
        order: order,
      ));
}
