import 'package:anth_package/anth_package.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/components/src/printer/bluetooth_printer_module.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/printer_detail/widgets/printer_device_item.dart';
import 'package:kaylee/utils/src/bluetooth_helper/bluetooth_helper.dart';
import 'package:kaylee/widgets/widgets.dart';

class BluetoothSelectDeviceDialog extends StatefulWidget {
  final ValueSetter<PrinterDevice?>? onSelected;

  BluetoothSelectDeviceDialog({
    this.onSelected,
  });

  @override
  _BluetoothSelectDeviceDialogState createState() =>
      _BluetoothSelectDeviceDialogState();
}

class _BluetoothSelectDeviceDialogState
    extends KayleeState<BluetoothSelectDeviceDialog>
    with BluetoothHelper<BluetoothSelectDeviceDialog> {
  PrinterDevice? _device;

  @override
  void initState() {
    super.initState();
    checkBluetoothPermission();
  }

  @override
  void dispose() {
    BluetoothPrint.instance.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenSize.height * 2 / 3,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px8)
                .copyWith(top: Dimens.px16, bottom: Dimens.px8),
            child: KayleeText.normal18W700(
              Strings.ketNoiVoiMayIn,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: StreamBuilder<List<BluetoothDevice>>(
              stream: BluetoothPrint.instance.scanResults,
              builder: (c, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: KayleeLoadingIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return SizedBox.shrink();
                }
                return KayleeListView(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                  itemBuilder: (context, index) {
                    final d = snapshot.data!.elementAt(index);
                    final device = PrinterDevice.bluetooth(
                      name: d.name,
                      address: d.address,
                      type: d.type,
                    );
                    return PrinterDeviceItem(
                      device: device
                        ..selected =
                            _device == null ? false : device.isEqual(_device!),
                      onTap: () {
                        _device = device;
                        setState(() {});
                      },
                    );
                  },
                  itemCount: snapshot.data?.length,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.px16, horizontal: Dimens.px16),
            child: Row(
              children: [
                Expanded(
                  child: KayLeeRoundedButton.button2(
                    text: Strings.huy,
                    onPressed: context.pop,
                    margin: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: Dimens.px16),
                Expanded(
                  child: _device.isNotNull
                      ? KayLeeRoundedButton.normal(
                          text: Strings.chon,
                          margin: EdgeInsets.zero,
                          onPressed: () {
                            widget.onSelected?.call(_device);
                            context.pop();
                          },
                        )
                      : KayLeeRoundedButton.button3(
                          text: Strings.chon,
                          margin: EdgeInsets.zero,
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void onGranted() {
    BluetoothPrint.instance.startScan(timeout: Duration(seconds: 4));
  }
}
