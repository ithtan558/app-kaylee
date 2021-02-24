import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeHorizontalDivider extends StatelessWidget {
  final double height;
  final double width;

  const KayleeHorizontalDivider(
      {this.height = 1, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(color: ColorsRes.textFieldBorder),
    );
  }
}
