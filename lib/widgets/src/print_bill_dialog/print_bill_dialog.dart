import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
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
  StreamSubscription bluetoothSub;
  bool showingBluetoothDialogSuccess = false;

  @override
  void initState() {
    super.initState();

    printerDevice = PrinterModule.connectedDevice;
    if (printerDevice.isBluetooth) {
      BluetoothPrinterModule.bluetoothPrint
          .startScan(timeout: Duration(seconds: 2));
    }
    bluetoothSub =
        BluetoothPrinterModule.listenConnectionState().listen((state) async {
      print('cur device status: $state');
      hideLoading();
      switch (state) {
        case BluetoothPrint.CONNECTED:
          if (!BluetoothPrinterModule.connected) {
            BluetoothPrinterModule.connected = true;
          }
          if (!showingBluetoothDialogSuccess) {
            showingBluetoothDialogSuccess = true;
            showKayleeAlertMessageYesDialog(
                context: context,
                message: Message(
                  content: Strings.ketNoiThanhCong,
                ),
                onPressed: () {
                  popScreen();
                  showingBluetoothDialogSuccess = false;
                });
          }
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    bluetoothSub.cancel();
    super.dispose();
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
                    child: (printerDevice?.isBluetooth ?? false)
                        ? StreamBuilder<List<BluetoothDevice>>(
                            stream: BluetoothPrinterModule
                                .bluetoothPrint.scanResults,
                            initialData: [],
                            builder: (context, buttonSnapshot) {
                              if (snapshot.hasData &&
                                  buttonSnapshot.hasData &&
                                  buttonSnapshot.data.isNotNullAndEmpty) {
                                return KayLeeRoundedButton.normal(
                                  margin: EdgeInsets.zero,
                                  text: Strings.In,
                                  onPressed: () async {
                                    //print with bluetooth
                                    return getPdfRasterForRol57(
                                      data: snapshot.data.save(),
                                      onPrint: (data) async {
                                        BluetoothPrinterModule.printOrder(
                                          onLoading: () {
                                            showLoading();
                                          },
                                          context: context,
                                          data: data,
                                          onFinished: () {
                                            hideLoading();
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                              return KayLeeRoundedButton.button3(
                                text: Strings.In,
                                margin: EdgeInsets.zero,
                              );
                            },
                          )
                        : KayLeeRoundedButton.normal(
                            margin: EdgeInsets.zero,
                            text: Strings.In,
                            onPressed: () async {
                              if (snapshot.hasData) {
                                //print with wifi
                                if ((printerDevice?.isWifi ?? false)) {
                                  showLoading();
                                  return getPdfRasterForRol80(
                                    data: snapshot.data.save(),
                                    onPrint: (data) async {
                                      await PrinterModule.connectPrinter(
                                          context,
                                          order: _order,
                                          image: data);
                                      hideLoading();
                                    },
                                  );
                                }

                                //print with bluetooth
                                if ((printerDevice?.isBluetooth ?? false)) {
                                  return getPdfRasterForRol57(
                                    data: snapshot.data.save(),
                                    onPrint: (data) async {
                                      BluetoothPrinterModule.printOrder(
                                        onLoading: () {
                                          showLoading();
                                        },
                                        context: context,
                                        data: data,
                                        onFinished: () {
                                          hideLoading();
                                        },
                                      );
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
