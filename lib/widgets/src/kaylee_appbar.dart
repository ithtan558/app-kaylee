import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/text_styles.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeAppBar extends StatelessWidget implements PreferredSizeWidget {
  factory KayleeAppBar.hyperTextAction(
          {String? title,
          Widget? titleWidget,
          Widget? leading,
          ValueGetter<bool>? onBack,
          String? actionTitle,
          VoidCallback? onActionClick,
          IconData? leadingIcon}) =>
      KayleeAppBar(
        title: title,
        titleWidget: titleWidget,
        leading: leading,
        onBack: onBack,
        actions: [
          if (actionTitle?.isNotEmpty ?? false)
            KayleeAppBarAction.hyperText(
              title: actionTitle!,
              onTap: onActionClick,
            )
        ],
        leadingIcon: leadingIcon,
      );

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final ValueGetter<bool>? onBack;
  final List<Widget>? actions;
  final IconData? leadingIcon;
  final bool automaticallyImplyLeading;

  KayleeAppBar({
    this.title,
    this.titleWidget,
    this.leading,
    this.onBack,
    this.actions,
    this.leadingIcon,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop;
    return AppBar(
      leading: leading != null
          ? leading
          : automaticallyImplyLeading
              ? canPop ?? false
                  ? FlatButton(
                      shape: CircleBorder(),
                      child: Icon(
                        leadingIcon ?? CupertinoIcons.back,
                        color: ColorsRes.hintText,
                      ),
                      onPressed: () {
                        if (onBack == null || onBack!()) {
                          context.pop();
                        }
                      },
                    )
                  : Container()
              : null,
      automaticallyImplyLeading: false,
      title: titleWidget ??
          KayleeText(
            title?.toUpperCase() ?? '',
            style: TextStyles.normal16W500,
          ),
      elevation: 0,
      brightness: Brightness.light,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class KayleeAppBarAction extends StatelessWidget {
  factory KayleeAppBarAction.hyperText(
          {required String title, VoidCallback? onTap}) =>
      KayleeAppBarAction(
        child: InkWell(
          onTap: onTap,
          customBorder: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: Center(
              child: HyperLinkText(
                text: title,
                onTap: onTap,
              ),
            ),
          ),
        ),
      );

  factory KayleeAppBarAction.button(
          {required Widget child, VoidCallback? onTap}) =>
      KayleeAppBarAction(
        child: SizedBox(
          height: kToolbarHeight,
          width: kToolbarHeight,
          child: InkWell(
            onTap: onTap,
            customBorder: CircleBorder(),
            child: Center(
              child: child,
            ),
          ),
        ),
      );

  factory KayleeAppBarAction.iconButton(
          {required String icon, Color? iconColor, VoidCallback? onTap}) =>
      KayleeAppBarAction(
        child: SizedBox(
          height: kToolbarHeight,
          width: kToolbarHeight,
          child: InkWell(
            onTap: onTap,
            customBorder: CircleBorder(),
            child: Center(
              child: ImageIcon(
                AssetImage(icon),
                color: iconColor ?? ColorsRes.hintText,
                size: Dimens.px20,
              ),
            ),
          ),
        ),
      );

  final Widget? child;

  KayleeAppBarAction({this.child});

  @override
  Widget build(BuildContext context) {
    return child ?? Container();
  }
}
