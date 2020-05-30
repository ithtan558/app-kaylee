import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeGridView extends StatelessWidget {
  final EdgeInsets padding;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final int crossAxisCount;
  final int mainAxisSpacing;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double childAspectRatio;

  KayleeGridView(
      {@required this.itemBuilder,
      this.padding,
      this.physics,
      this.shrinkWrap,
      this.crossAxisCount,
      this.mainAxisSpacing,
      this.childAspectRatio,
      this.itemCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding ?? EdgeInsets.all(Dimens.px16),
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount ?? 3,
          crossAxisSpacing: crossAxisCount ?? Dimens.px16,
          mainAxisSpacing: mainAxisSpacing ?? Dimens.px16,
          childAspectRatio: childAspectRatio ?? 1),
      itemBuilder: itemBuilder,
      itemCount: itemCount ?? 0,
    );
  }
}
