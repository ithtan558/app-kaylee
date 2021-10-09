import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  const KayleeAppBar({
    Key? key,
    this.title,
    this.titleWidget,
    this.leading,
    this.onBack,
    this.actions,
    this.leadingIcon,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop;
    return AppBar(
      leading: leading ??
          (automaticallyImplyLeading
              ? canPop ?? false
                  ? TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                        const CircleBorder(),
                      )),
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
              : null),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class KayleeAppBarAction extends StatelessWidget {
  KayleeAppBarAction.hyperText(
      {Key? key, required String title, VoidCallback? onTap})
      : child = InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
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
        super(key: key);

  KayleeAppBarAction.button(
      {Key? key, required Widget child, VoidCallback? onTap})
      : child = SizedBox(
          height: kToolbarHeight,
          width: kToolbarHeight,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Center(
              child: child,
            ),
          ),
        ),
        super(key: key);

  KayleeAppBarAction.iconButton({
    Key? key,
    required String icon,
    Color? iconColor,
    VoidCallback? onTap,
    double size = Dimens.px20,
  })  : child = SizedBox(
          height: kToolbarHeight,
          width: kToolbarHeight,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Center(
              child: ImageIcon(
                AssetImage(icon),
                color: iconColor ?? ColorsRes.hintText,
                size: size,
              ),
            ),
          ),
        ),
        super(key: key);

  final Widget? child;

  const KayleeAppBarAction({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child ?? Container();
  }
}
