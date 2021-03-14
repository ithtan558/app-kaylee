import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/components/src/printer/bluetooth_printer_module.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/printer_detail/blocs/printer_detail_bloc.dart';
import 'package:kaylee/screens/src/printer_detail/widgets/bluetooth_select_device_dialog.dart';
import 'package:kaylee/screens/src/printer_detail/widgets/printer_device_item.dart';
import 'package:kaylee/screens/src/printer_detail/widgets/wifi_printer_device_input_dialog.dart';
import 'package:kaylee/widgets/widgets.dart';

class PrinterDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => PrinterDetailBloc(), child: PrinterDetailScreen._());

  PrinterDetailScreen._();

  @override
  _PrinterDetailScreenState createState() => _PrinterDetailScreenState();
}

class _PrinterDetailScreenState extends KayleeState<PrinterDetailScreen> {
  final _ipTFController = TextEditingController();

  PrinterDetailBloc get _bloc => context.bloc<PrinterDetailBloc>();
  StreamSubscription _bluetoothSub;

  @override
  void initState() {
    super.initState();
    _bloc.initState();
    _bluetoothSub =
        BluetoothPrinterModule.listenConnectionState().listen((state) async {
      print('cur device status: $state');
      hideLoading();
      switch (state) {
        case BluetoothPrint.CONNECTED:
          showKayleeAlertMessageYesDialog(
              context: context,
              message: Message(content: Strings.ketNoiThanhCong),
              onPressed: () async {
                popScreen();
                BluetoothPrinterModule.printConnectionInfo(
                    device: _bloc.connectedDevice);
              });
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _bluetoothSub.cancel();
    _ipTFController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar.hyperTextAction(
          title: Strings.caiDatMayIn,
          actionTitle: Strings.caiDat,
          onActionClick: () {
            showDeviceOption(
              context: context,
              onSelectWifi: _bloc.onSelectWifi,
              onSelectBluetooth: _bloc.onSelectBluetooth,
            );
          },
        ),
        body: BlocListener<PrinterDetailBloc, PrinterDetailState>(
          listener: (context, state) async {
            if (state is PrinterDetailStateOnSelectWifi) {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return WifiPrinterDeviceInputDialog(
                    onSave: (value) {
                      _bloc.onAddWifi(ip: value);
                    },
                  );
                },
              );
              return;
            }
            if (state is PrinterDetailStateOnSelectBluetooth) {
              showKayleeDialog(
                  context: context,
                  child: BluetoothSelectDeviceDialog(
                    onSelected: (device) {
                      _bloc.onAddBluetooth(device: device);
                    },
                  ));
              return;
            }
            if (state is PrinterDetailStateSavedDefaultDeviceBluetooth) {
              showLoading();
              BluetoothPrinterModule.connect(device: _bloc.connectedDevice);
              return;
            }
            if (state is PrinterDetailStateSavedDefaultDeviceWifi) {
              tryToConnectPrinterDevice(
                  device: _bloc.connectedDevice, context: context);
              return;
            }
          },
          child: Column(
            children: [
              Expanded(
                  child: BlocBuilder<PrinterDetailBloc, PrinterDetailState>(
                builder: (context, state) {
                  return KayleeListView(
                    itemBuilder: (context, index) {
                      final device = _bloc.devices.elementAt(index);
                      return PrinterDeviceItem(
                        device: device,
                        onTap: () {
                          _bloc.select(device: device);
                        },
                      );
                    },
                    itemCount: _bloc.devices.length,
                  );
                },
              )),
              BlocBuilder<PrinterDetailBloc, PrinterDetailState>(
                buildWhen: (previous, current) =>
                    current is PrinterDetailStateSavedDefaultDevice ||
                    current is PrinterDetailStateOnSelectingDevice ||
                    current is PrinterDetailStateOnNoSelectingDevice,
                builder: (context, state) {
                  if (state is PrinterDetailStateOnSelectingDevice) {
                    return KayLeeRoundedButton.normal(
                      text: Strings.datLamMacDinh,
                      margin:
                          const EdgeInsets.symmetric(horizontal: Dimens.px16)
                              .copyWith(bottom: Dimens.px16),
                      onPressed: () async {
                        _bloc.saveDefaultDevice();
                        // final device = PrinterDevice(
                        //   ip: _ipTFController.text,
                        // );
                        // PrinterModule.savePrinterDevice(device: device);
                        // tryToConnectPrinterDevice(context: context, device: device);
                      },
                    );
                  }
                  return KayLeeRoundedButton.button3(
                    text: Strings.datLamMacDinh,
                    margin: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                        .copyWith(bottom: Dimens.px16),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void tryToConnectPrinterDevice({BuildContext context, PrinterDevice device}) async {
    showLoading();
    final connected = await PrinterModule.printConnectionInfo(device: device);
    hideLoading();
    if (connected) {
      showKayleeAlertMessageYesDialog(
        context: context,
        message: Message(content: Strings.luuThanhCong),
        onPressed: popScreen,
      );
    } else {
      showKayleeDialogNotAbleToConnectPrinter(
        context: context,
        onTryAgain: () async {
          tryToConnectPrinterDevice(context: context, device: device);
        },
      );
    }
  }
}

Future showDeviceOption({
  BuildContext context,
  VoidCallback onSelectWifi,
  VoidCallback onSelectBluetooth,
}) {
  return showKayleeAlertDialog(
    context: context,
    view: KayleeAlertDialogView(
      content: Strings.luaChonLoaThietBi,
      actions: [
        KayleeAlertDialogAction(
          title: Strings.wifi,
          onPressed: () {
            onSelectWifi?.call();
            context.pop();
          },
        ),
        KayleeAlertDialogAction(
          title: Strings.bluetooth,
          onPressed: () {
            onSelectBluetooth?.call();
            context.pop();
          },
        ),
        KayleeAlertDialogAction.huy(
          onPressed: () {
            context.pop();
          },
        ),
      ],
    ),
  );
}
