import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KayleeDismissible extends StatelessWidget {
  final Widget child;

  ///called when this widget is completely removed from the listview
  final void Function(DismissDirection direction)? onDismissed;
  final AsyncValueGetter<bool>? confirmDismiss;
  final Widget? secondaryBackground;

  const KayleeDismissible(
      {required Key key,
      required this.child,
      this.onDismissed,
      this.confirmDismiss,
      this.secondaryBackground})
      : super(key: key);

  ///delete icon without text
  factory KayleeDismissible.iconOnly({
    required Key key,
    required Widget child,
    void Function(DismissDirection direction)? onDismissed,
    AsyncValueGetter<bool>? confirmDismiss,
  }) {
    return KayleeDismissible(
      key: key,
      child: child,
      onDismissed: onDismissed,
      confirmDismiss: confirmDismiss,
      secondaryBackground: Container(
        color: ColorsRes.errorBorder,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: Dimens.px24),
        child: Image.asset(
          IconAssets.icDelete,
          package: anthPackage,
          width: Dimens.px24,
          height: Dimens.px24,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.black,
      ),
      confirmDismiss: (direction) {
        return confirmDismiss?.call() ?? Future.value(true);
      },
      secondaryBackground: secondaryBackground ??
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px24),
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconAssets.icDelete,
                  package: anthPackage,
                  width: Dimens.px32,
                  height: Dimens.px32,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.px4),
                  child: KayleeText.error16W400(
                    StringsRes.xoa,
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
