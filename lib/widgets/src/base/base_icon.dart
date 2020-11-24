import 'package:flutter/material.dart';

abstract class BaseIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color color;

  BaseIcon({this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(icon),
      size: size ?? 24,
      color: color,
    );
  }
}
