import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeDismissible extends StatelessWidget {
  final Widget child;
  final void Function(DismissDirection direction) onDismissed;

  KayleeDismissible({Key key, this.child, this.onDismissed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(),
      secondaryBackground: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.px24),
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.ic_delete,
              width: Dimens.px32,
              height: Dimens.px32,
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px4),
              child: KayleeText(
                Strings.xoa,
                maxLines: 1,
                style: TextStyles.error16W500,
              ),
            )
          ],
        ),
      ),
      onDismissed: onDismissed,
      child: child,
    );
  }
}
