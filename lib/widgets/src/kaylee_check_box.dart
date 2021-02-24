import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeCheckBox extends StatelessWidget {
  final VoidCallback onChecked;
  final bool checked;

  KayleeCheckBox({this.onChecked, this.checked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChecked?.call,
      child: Image.asset(
        checked ? Images.ic_checked_1 : Images.ic_notcheck,
        width: Dimens.px24,
        height: Dimens.px24,
      ),
    );
  }
}
