import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeCartView extends StatelessWidget {
  final Widget child;
  final double itemHeight;
  final BorderRadius borderRadius;

  KayleeCartView({@required this.child, this.itemHeight, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: itemHeight,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(Dimens.px10),
        boxShadow: [
          BoxShadow(
              color: ColorsRes.shadow,
              offset: Offset(0, 1),
              blurRadius: Dimens.px5,
              spreadRadius: 0)
        ],
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(Dimens.px10),
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}
