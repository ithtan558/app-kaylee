import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayLeeRoundedButton extends StatelessWidget {
  final double? width;
  final String? text;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;
  final BorderSide? borderSide;
  final Color? color;
  final Widget? child;
  final double? height;

  factory KayLeeRoundedButton.button2(
          {String? text,
          EdgeInsets? margin,
          VoidCallback? onPressed,
          double? width}) =>
      KayLeeRoundedButton(
        text: text,
        margin: margin,
        onPressed: onPressed,
        width: width,
        borderSide: const BorderSide(
          width: Dimens.px1,
          color: ColorsRes.text,
        ),
        color: ColorsRes.hintText,
      );

  factory KayLeeRoundedButton.button3(
          {String? text,
          EdgeInsets? margin,
          VoidCallback? onPressed,
          double? width}) =>
      KayLeeRoundedButton(
        text: text,
        margin: margin,
        onPressed: onPressed,
        width: width,
        color: ColorsRes.button1,
      );

  factory KayLeeRoundedButton.normal({
    String? text,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    double? width,
    Widget? child,
    double? height,
  }) =>
      KayLeeRoundedButton(
        height: height,
        text: text,
        margin: margin,
        onPressed: onPressed,
        width: width,
        child: child,
      );

  const KayLeeRoundedButton({
    Key? key,
    this.width,
    this.text,
    this.onPressed,
    this.margin,
    this.borderSide,
    this.color,
    this.child,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Dimens.px48,
      width: width ?? double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: TextButton(
        onPressed: () {
          onPressed?.call();
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              StadiumBorder(side: borderSide ?? BorderSide.none)),
          splashFactory: InkSplash.splashFactory,
          overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.7)),
          backgroundColor: MaterialStateProperty.all(color ?? ColorsRes.button),
        ),
        child: child ??
            KayleeText.normalWhite16W500(
              text ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
      ),
    );
  }
}
