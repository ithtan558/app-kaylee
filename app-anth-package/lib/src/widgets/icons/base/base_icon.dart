import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

abstract class BaseIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;
  final String? package;

  const BaseIcon(
      {Key? key, required this.icon, this.size, this.color, this.package})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(icon, package: package),
      size: size ?? Dimens.px24,
      color: color,
    );
  }
}
