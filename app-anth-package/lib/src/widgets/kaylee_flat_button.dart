import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeFlatButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String? title;
  final Widget? child;
  final Color? background;
  final BorderRadius? borderRadius;
  final EdgeInsets? titlePadding;
  final double? height;
  final TextStyle? style;

  const KayleeFlatButton({
    Key? key,
    this.onPress,
    this.title,
    this.child,
    this.background,
    this.borderRadius,
    this.titlePadding,
    this.height,
    this.style,
  }) : super(key: key);

  factory KayleeFlatButton.normal({
    String? title,
    VoidCallback? onPress,
    double? height,
  }) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        height: height,
      );

  factory KayleeFlatButton.withTextField(
          {String? title, VoidCallback? onPress}) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        titlePadding: const EdgeInsets.symmetric(horizontal: Dimens.px14),
      );

  factory KayleeFlatButton.withLabelDivider(
          {String? title, VoidCallback? onPress}) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        titlePadding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      );

  factory KayleeFlatButton.filter(
          {VoidCallback? onPress, Color? background, Widget? child}) =>
      KayleeFlatButton(
        onPress: onPress,
        borderRadius: BorderRadius.circular(Dimens.px10),
        background: background,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Dimens.px40,
      child: TextButton(
          onPressed: onPress,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(titlePadding ??
                const EdgeInsets.symmetric(horizontal: Dimens.px8)),
            backgroundColor:
                MaterialStateProperty.all(background ?? ColorsRes.hyper),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(Dimens.px5))),
          ),
          clipBehavior: Clip.antiAlias,
          child: child != null
              ? child!
              : KayleeText(
            title ?? '',
                  style: style ?? TextStyles.normalWhite16W500,
                  maxLines: 1,
                )),
    );
  }
}
