import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeListView extends StatelessWidget {
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final IndexedWidgetBuilder itemBuilder;
  final int? itemCount;
  final IndexedWidgetBuilder? separatorBuilder;
  final WidgetBuilder? loadingBuilder;
  final ScrollController? controller;

  const KayleeListView({Key? key,
    required this.itemBuilder,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.itemCount,
    this.loadingBuilder,
    this.separatorBuilder,
    this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final length = (itemCount ?? 0) + 1;
    return ListView.separated(
      controller: controller,
      padding: padding ?? const EdgeInsets.all(Dimens.px16),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        if (index == length - 1) {
          //build loading
          return loadingBuilder?.call(context) ?? const SizedBox.shrink();
        } else {
          return itemBuilder(context, index);
        }
      },
      itemCount: length,
      separatorBuilder: (context, index) {
        if (index == length - 2) return Container();
        return separatorBuilder?.call(context, index) ??
            const SizedBox.shrink();
      },
    );
  }
}
