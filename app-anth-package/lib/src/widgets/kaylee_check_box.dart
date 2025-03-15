import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeCheckBox extends StatelessWidget {
  final VoidCallback? onChecked;
  final bool checked;

  const KayleeCheckBox({Key? key, this.onChecked, this.checked = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChecked?.call,
      child: Image.asset(
        checked ? IconAssets.icCheckActive : IconAssets.icCheckInactive,
        width: Dimens.px24,
        height: Dimens.px24,
        package: anthPackage,
      ),
    );
  }
}
