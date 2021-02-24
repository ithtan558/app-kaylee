import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeHorizontalDivider extends StatelessWidget {
  final double height;

  const KayleeHorizontalDivider({this.height = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: new BoxDecoration(color: ColorsRes.textFieldBorder),
    );
  }
}
