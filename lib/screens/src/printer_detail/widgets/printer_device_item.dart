import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/components/components.dart';

class PrinterDeviceItem extends StatelessWidget {
  final PrinterDevice device;
  final VoidCallback onTap;

  const PrinterDeviceItem({
    Key? key,
    required this.device,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            KayleeCheckBox(checked: device.selected),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: Dimens.px16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KayleeText.normal16W500(device.deviceName),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px8),
                      child:
                      KayleeText.normal16W400(device.deviceAddress ?? ''),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
