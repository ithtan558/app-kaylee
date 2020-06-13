import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeDismissible extends StatelessWidget {
  final Widget child;
  final void Function(DismissDirection direction) onDismissed;
  final AsyncValueGetter<bool> confirmDismiss;

  KayleeDismissible(
      {@required Key key,
      @required this.child,
      this.onDismissed,
      this.confirmDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(),
      confirmDismiss: (direction) async {
        if (confirmDismiss.isNotNull) {
          return await confirmDismiss();
        }
        return true;
      },
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
              child: KayleeText.error16W400(
                Strings.xoa,
                maxLines: 1,
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
