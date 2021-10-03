import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeHorizontalDivider extends StatelessWidget {
  final double height;
  final double width;

  const KayleeHorizontalDivider({Key? key, this.height = 1, this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(color: ColorsRes.textFieldBorder),
    );
  }
}
