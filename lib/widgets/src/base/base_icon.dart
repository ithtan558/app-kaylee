import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

abstract class BaseIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;

  const BaseIcon({Key? key, required this.icon, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(icon),
      size: size ?? Dimens.px24,
      color: color,
    );
  }
}
