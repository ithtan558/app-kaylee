import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeInkwell extends StatelessWidget {
  final Widget child;
  final void Function() onTap;

  KayleeInkwell({this.child, this.onTap});

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
          borderRadius: BorderRadius.circular(Dimens.px10),
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
