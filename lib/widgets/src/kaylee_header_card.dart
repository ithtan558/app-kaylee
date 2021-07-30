import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeHeaderCard extends StatelessWidget {
  final Widget? header;
  final Widget? child;
  final EdgeInsets? headerPadding;

  const KayleeHeaderCard(
      {Key? key,
      this.header,
      this.child,
      this.headerPadding = const EdgeInsets.all(Dimens.px16)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KayleeCartView(
      borderRadius: BorderRadius.circular(Dimens.px10),
      child: Material(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: headerPadding,
              color: ColorsRes.color2,
              child: header ?? const SizedBox.shrink(),
            ),
            child ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
