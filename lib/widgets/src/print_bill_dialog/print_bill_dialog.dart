import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:anth_package/anth_package.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/material.dart' hide TextStyle;
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/components/src/printer/bluetooth_printer_module.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/printer_detail/blocs/base/printer_detail_base.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintBillDialog extends StatefulWidget {
  static Widget newInstance({required Order order}) => BlocProvider(
        create: (context) => Platform.isAndroid
            ? AndroidPrinterDialogBloc()
            : IosPrinterDialogBloc(),
        child: PrintBillDialog._(
          order: order,
        ),
      );

  final Order order;

  const PrintBillDialog._({required this.order});

  @override
  _PrintBillDialogState createState() => _PrintBillDialogState();
}

class _PrintBillDialogState extends KayleeState<PrintBillDialog> {
  Order get _order => widget.order;
  bool showingBluetoothDialogSuccess = false;

  PrinterDetailBase get _bloc => context.read<PrinterDetailBase>();

  @override
  void initState() {
    super.initState();
    _bloc.initState();
  }

  late Uint8List _data;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrinterDetailBase, PrinterDetailState>(
      listener: (context, state) async {
        if (state is PrinterDetailStateConnectedBluetooth) {
          hideLoading();
          BluetoothPrinterModule.printOrder(
            onLoading: () {
              // showLoading();
            },
            context: context,
            data: _data,
            onFinished: () {
              // hideLoading();
            },
          );
          // if (!showingBluetoothDialogSuccess) {
          //   showingBluetoothDialogSuccess = true;
          //   showKayleeAlertMessageYesDialog(
          //       context: context,
          //       message: Message(content: Strings.ketNoiThanhCong),
          //       onPressed: () {
          //         popScreen();
          //         showingBluetoothDialogSuccess = false;
          //         BluetoothPrinterModule.printOrder(
          //           onLoading: () {
          //             // showLoading();
          //           },
          //           context: context,
          //           data: _data,
          //           onFinished: () {
          //             // hideLoading();
          //           },
          //         );
          //       });
          // }
          return;
        }
        if (state is PrinterDetailStateCannotConnectBluetoothDevice) {
          hideLoading();
          showKayleeAlertErrorYesDialog(
            context: context,
            error:
                Error(message: Strings.khongTheKetNoiVoiPrinterVuilongRestart),
            onPressed: popScreen,
          );
          return;
        }

        if (state is PrinterDetailStateBluetoothCheckingEnable) {
          return showLoading();
        }

        if (state is PrinterDetailStateBluetoothEnable) {
          if ((Platform.isIOS && BluetoothPrinterModule.connected) ||
              ((await BluetoothPrint.instance.isConnected) ?? false)) {
            hideLoading();
            BluetoothPrinterModule.printOrder(
              onLoading: () {
                // showLoading();
              },
              context: context,
              data: _data,
              onFinished: () {
                // hideLoading();
              },
            );
          } else {
            _bloc.startConnectingBluetoothDevice();
          }
          return;
        }

        if (state is PrinterDetailStateBluetoothNotEnable) {
          hideLoading();
          context.systemSetting
              .showKayleeBluetoothSettingDialog(context: context);
          return;
        }
      },
      child: FutureBuilder<pw.Document>(
        future: (_bloc.defaultDevice?.isBluetooth ?? false)
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
                child: SizedBox(
                  height: context.screenSize.height,
                  child: snapshot.hasData
                      ? PdfPreview(
                          build: (format) => snapshot.data!.save(),
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
                    const SizedBox(width: Dimens.px8),
                    Expanded(
                      child: (_bloc.defaultDevice?.isBluetooth ?? false)
                          ? BlocBuilder<PrinterDetailBase, PrinterDetailState>(
                              builder: (context, state) {
                                if (snapshot.hasData &&
                                    state
                                        is! PrinterDetailStateLoadingDevices) {
                                  return KayLeeRoundedButton.normal(
                                    margin: EdgeInsets.zero,
                                    text: Strings.print,
                                    onPressed: () async {
                                      //print with bluetooth
                                      return getPdfRasterForRol57(
                                        data: snapshot.data!.save(),
                                        onPrint: (data) async {
                                          _data = data;
                                          _bloc.checkBluetoothEnable();
                                        },
                                      );
                                    },
                                  );
                                }
                                return KayLeeRoundedButton.button3(
                                  text: Strings.print,
                                  margin: EdgeInsets.zero,
                                );
                              },
                            )
                          : _buildWifiPrintButton(snapshot: snapshot),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildWifiPrintButton({required AsyncSnapshot<pw.Document> snapshot}) {
    return KayLeeRoundedButton.normal(
      margin: EdgeInsets.zero,
      text: Strings.print,
      onPressed: () async {
        if (snapshot.hasData) {
          //print with wifi
          showLoading();
          return getPdfRasterForRol80(
            data: snapshot.data!.save(),
            onPrint: (data) async {
              await PrinterModule.connectPrinter(context,
                  order: _order, image: data);
              hideLoading();
            },
          );
        }
      },
    );
  }
}

Future<void> showKayleePrintOrderDialog(
    {required BuildContext context, required Order order}) {
  return showKayleeDialog(
      context: context,
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px24)
          .copyWith(bottom: Dimens.px20),
      child: PrintBillDialog.newInstance(
        order: order,
      ));
}
