import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeListView extends StatelessWidget {
  final EdgeInsets padding;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final int crossAxisCount;
  final int mainAxisSpacing;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double childAspectRatio;
  final IndexedWidgetBuilder separatorBuilder;
  final WidgetBuilder loadingBuilder;
  final ScrollController controller;

  KayleeListView(
      {@required this.itemBuilder,
      this.padding,
      this.physics,
      this.shrinkWrap,
      this.crossAxisCount,
      this.mainAxisSpacing,
      this.childAspectRatio,
      this.itemCount,
      this.loadingBuilder,
      this.separatorBuilder,
      this.controller});

  @override
  Widget build(BuildContext context) {
    final length = itemCount + 1;
    return ListView.separated(
      controller: controller,
      padding: padding ?? EdgeInsets.all(Dimens.px16),
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      itemBuilder: (context, index) {
        if (index == length - 1) {
          //build loading
          return loadingBuilder?.call(context) ?? Container();
        } else // build main item
          return itemBuilder?.call(context, index) ?? Container();
      },
      itemCount: length,
      separatorBuilder: (context, index) {
        if (index == length - 2) return Container();
        return separatorBuilder?.call(context, index);
      },
    );
  }
}
