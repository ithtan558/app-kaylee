import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/text_styles.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeAppBar extends StatelessWidget implements PreferredSizeWidget {
  factory KayleeAppBar.hyperTextAction(
          {String title,
          Widget titleWidget,
          Widget leading,
          bool Function() onBack,
          String actionTitle,
          VoidCallback onActionClick,
          IconData leadingIcon}) =>
      KayleeAppBar(
        title: title,
        titleWidget: titleWidget,
        leading: leading,
        onBack: onBack,
        actions: [
          if (actionTitle.isNotNullAndEmpty)
            KayleeAppBarAction.hyperText(
              title: actionTitle,
              onTap: onActionClick,
            )
        ],
        leadingIcon: leadingIcon,
      );

  final String title;
  final Widget titleWidget;
  final Widget leading;
  final bool Function() onBack;
  final List<Widget> actions;
  final IconData leadingIcon;

  KayleeAppBar(
      {this.title,
      this.titleWidget,
      this.leading,
      this.onBack,
      this.actions,
      this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop;
    return AppBar(
      leading: leading.isNotNull
          ? leading
          : canPop
              ? FlatButton(
                  shape: CircleBorder(),
                  child: Icon(
                    leadingIcon ?? CupertinoIcons.back,
                    color: ColorsRes.hintText,
                  ),
                  onPressed: () {
                    if (onBack == null || onBack()) {
                      context.pop();
                    }
                  },
                )
              : Container(),
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
          {@required String title, void Function() onTap}) =>
      KayleeAppBarAction(
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.only(right: Dimens.px16),
          alignment: Alignment.centerRight,
          child: HyperLinkText(
            text: title ?? '',
            onTap: onTap,
          ),
        ),
      );

  factory KayleeAppBarAction.button(
          {@required Widget child, void Function() onTap}) =>
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

  final Widget child;

  KayleeAppBarAction({this.child});

  @override
  Widget build(BuildContext context) {
    return child ?? Container();
  }
}
