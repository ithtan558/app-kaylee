import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

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
        checked ? Images.icChecked1 : Images.icNotCheck,
        width: Dimens.px24,
        height: Dimens.px24,
      ),
    );
  }
}
