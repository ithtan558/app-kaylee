import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/text_styles.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final bool Function() onBack;
  final List<Widget> actions;

  KayleeAppBar({this.title, this.leading, this.onBack, this.actions});

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop;
    return AppBar(
      leading: canPop
          ? FlatButton(
              shape: CircleBorder(),
              child: Icon(
                CupertinoIcons.back,
                color: ColorsRes.hintText,
              ),
              onPressed: () {
                if (onBack == null || onBack()) {
                  pop(PageIntent(context, null));
                }
              },
            )
          : leading,
      automaticallyImplyLeading: false,
      title: KayleeText(
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
