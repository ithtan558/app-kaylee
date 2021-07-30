import 'dart:async';
import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/printer_detail/blocs/base/printer_detail_base.dart';
import 'package:kaylee/screens/src/printer_detail/widgets/bluetooth_select_device_dialog.dart';
import 'package:kaylee/screens/src/printer_detail/widgets/stored_printer_device_item.dart';
import 'package:kaylee/screens/src/printer_detail/widgets/wifi_printer_device_input_dialog.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class PrinterDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<PrinterDetailBase>(
      create: (context) => Platform.isAndroid
          ? AndroidPrinterDetailBloc()
          : IosPrinterDetailBloc(),
      child: PrinterDetailScreen._());

  PrinterDetailScreen._();

  @override
  _PrinterDetailScreenState createState() => _PrinterDetailScreenState();
}

class _PrinterDetailScreenState extends KayleeState<PrinterDetailScreen> {
  final _ipTFController = TextEditingController();

  PrinterDetailBase get _bloc => context.bloc<PrinterDetailBase>()!;

  bool showingBluetoothDialogSuccess = false;

  @override
  void initState() {
    super.initState();
    _bloc.initState();
  }

  @override
  void dispose() {
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
        body: BlocListener<PrinterDetailBase, PrinterDetailState>(
          listener: (context, state) async {
            print('[TUNG] ===> PrinterDetailState $state');
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
              return _bloc.checkBluetoothEnable();
            }

            if (state
                is PrinterDetailStateStartingConnectBluetoothDeviceProcess) {
              return showLoading();
            }
            if (state is PrinterDetailStateConnectedBluetooth) {
              hideLoading();
              if (!showingBluetoothDialogSuccess) {
                showingBluetoothDialogSuccess = true;
                showKayleeAlertMessageYesDialog(
                    context: context,
                    message: Message(content: Strings.ketNoiThanhCong),
                    onPressed: () {
                      popScreen();
                      showingBluetoothDialogSuccess = false;
                      _bloc.printBluetoothConnectionInfo();
                    });
              }
              return;
            }
            if (state is PrinterDetailStateCannotConnectBluetoothDevice) {
              hideLoading();
              return showKayleeAlertErrorYesDialog(
                context: context,
                error: Error(
                    message: Strings.khongTheKetNoiVoiPrinterVuilongRestart),
                onPressed: popScreen,
              );
            }
            if (state is PrinterDetailStateSavedDefaultDeviceWifi) {
              tryToConnectPrinterDevice(
                  device: _bloc.defaultDevice, context: context);
              return;
            }

            if (state is PrinterDetailStateBluetoothCheckingEnable) {
              return showLoading();
            }

            if (state is PrinterDetailStateBluetoothEnable) {
              hideLoading();
              final isShownProminentDisclosure =
                  SharedRef.getBool(locationProminentDisclosureForAndroidKey);
              if (isShownProminentDisclosure) {
                return _showSelectingBluetoothDevice();
              } else {
                return context.systemSetting
                    .showKayleeLocationPermissionExplainsDialog(
                  context: context,
                  allowCallback: () {
                    SharedRef.putBool(
                        locationProminentDisclosureForAndroidKey, true);
                    _showSelectingBluetoothDevice();
                  },
                );
              }
            }

            if (state is PrinterDetailStateBluetoothNotEnable) {
              hideLoading();
              return context.systemSetting
                  .showKayleeBluetoothSettingDialog(context: context);
            }

            if (state is PrinterDetailStateRemovingConnectionBluetoothDevice) {
              return showLoading();
            }
            if (state is PrinterDetailStateRemovedConnectionBluetoothDevice) {
              return hideLoading();
            }

            if (state is PrinterDetailStateLostConnectionBluetoothDevice) {
              return showKayleeAlertErrorYesDialog(
                context: context,
                error: Error(
                    message:
                        Strings.khongGiuDuocKetNoiVoiPrinterVuilongRestart),
                onPressed: popScreen,
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                  child: BlocBuilder<PrinterDetailBase, PrinterDetailState>(
                builder: (context, state) {
                  if (state is PrinterDetailStateLoadingDevices ||
                      state is PrinterDetailStateInitial)
                    return KayleeLoadingIndicator();
                  return KayleeListView(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                    itemBuilder: (context, index) {
                      final device = _bloc.devices.elementAt(index);
                      return StoredPrinterDeviceItem(
                        device: device,
                        onTap: () {
                          _bloc.select(device: device);
                        },
                        onRemoveItem: () {
                          _bloc.removeDevice(device: device);
                        },
                      );
                    },
                    itemCount: _bloc.devices.length,
                  );
                },
              )),
              BlocBuilder<PrinterDetailBase, PrinterDetailState>(
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

  void tryToConnectPrinterDevice(
      {required BuildContext context, PrinterDevice? device}) async {
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

  void _showSelectingBluetoothDevice() {
    showKayleeDialog(
        context: context,
        child: BluetoothSelectDeviceDialog(
          onSelected: (device) {
            _bloc.onAddBluetooth(device: device);
          },
        ));
  }
}

Future showDeviceOption({
  required BuildContext context,
  required VoidCallback onSelectWifi,
  required VoidCallback onSelectBluetooth,
}) {
  return showKayleeAlertDialog(
    context: context,
    view: KayleeAlertDialogView(
      content: Strings.luaChonLoaThietBi,
      actions: [
        KayleeAlertDialogAction(
          title: Strings.wifi,
          onPressed: () {
            onSelectWifi.call();
            context.pop();
          },
        ),
        KayleeAlertDialogAction(
          title: Strings.bluetooth,
          onPressed: () {
            onSelectBluetooth.call();
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
