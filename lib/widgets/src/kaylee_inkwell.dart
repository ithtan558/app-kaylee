import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeInkwell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  KayleeInkwell({required this.child, this.onTap, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned.fill(
          child: child,
        ),
        Positioned.fill(
            child: Material(
              borderRadius: borderRadius ?? BorderRadius.circular(Dimens.px10),
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
          ),
        ))
      ],
    );
  }
}
