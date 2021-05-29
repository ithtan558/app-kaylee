import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeGridView extends StatelessWidget {
  static SliverGridDelegateWithFixedCrossAxisCount gridDelegate(
          {int crossAxisCount = 3,
          double crossAxisSpacing = Dimens.px16,
          double mainAxisSpacing = Dimens.px16,
          double childAspectRatio = 1}) =>
      SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: childAspectRatio);

  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final int? crossAxisCount;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final IndexedWidgetBuilder itemBuilder;
  final int? itemCount;
  final double childAspectRatio;
  final WidgetBuilder? loadingBuilder;

  KayleeGridView(
      {required this.itemBuilder,
      this.padding,
      this.physics,
      this.shrinkWrap = false,
      this.crossAxisCount,
      this.crossAxisSpacing,
      this.mainAxisSpacing,
      this.childAspectRatio = 1,
      this.itemCount,
      this.loadingBuilder});

  @override
  Widget build(BuildContext context) {
    final length = itemLength(itemCount);
    return GridView.builder(
      padding: padding ?? EdgeInsets.all(Dimens.px16),
      physics: physics,
      gridDelegate: gridDelegate(
        childAspectRatio: childAspectRatio,
        crossAxisCount: crossAxisCount ?? 3,
        crossAxisSpacing: crossAxisSpacing ?? Dimens.px16,
        mainAxisSpacing: mainAxisSpacing ?? Dimens.px16,
      ),
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        if (index == length - 1) {
          //build loading
          return IntrinsicHeight(
              child: loadingBuilder?.call(context) ?? Container());
        } else if (index >= (itemCount ?? 0)) {
          //build empty item
          return IntrinsicHeight(
            child: Container(
              height: 0,
            ),
          );
        } else // build main item
          return itemBuilder.call(context, index);
      },
      itemCount: length,
    );
  }

  int itemLength(int? itemCount) {
    itemCount ??= 0;
    final x = itemCount % 3 == 0 ? 0 : (3 - itemCount % 3);
    return itemCount + x + 2;
  }
}
