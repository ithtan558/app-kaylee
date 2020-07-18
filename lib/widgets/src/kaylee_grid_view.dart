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
  final WidgetBuilder loadingBuilder;

  KayleeGridView(
      {@required this.itemBuilder,
      this.padding,
      this.physics,
      this.shrinkWrap,
      this.crossAxisCount,
      this.mainAxisSpacing,
      this.childAspectRatio,
      this.itemCount,
      this.loadingBuilder});

  @override
  Widget build(BuildContext context) {
    final length = itemLength(itemCount);
    return GridView.builder(
      padding: padding ?? EdgeInsets.all(Dimens.px16),
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount ?? 3,
          crossAxisSpacing: crossAxisCount ?? Dimens.px16,
          mainAxisSpacing: mainAxisSpacing ?? Dimens.px16,
          childAspectRatio: childAspectRatio ?? 1),
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
          return itemBuilder?.call(context, index) ?? Container();
      },
      itemCount: length,
    );
  }

  int itemLength(int itemCount) {
    itemCount ??= 0;
    final x = itemCount % 3 == 0 ? 0 : (3 - itemCount % 3);
    return itemCount + x + 2;
  }
}
