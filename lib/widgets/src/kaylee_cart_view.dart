import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeCartView extends StatelessWidget {
  final Widget child;

  KayleeCartView({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.px10),
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
          borderRadius: BorderRadius.circular(Dimens.px10),
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}
