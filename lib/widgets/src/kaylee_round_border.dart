import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeRoundBorder extends StatelessWidget {
  factory KayleeRoundBorder.hyper({BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? padding,
    Widget? child,
    double? width,
    double? height,
    Color? bgColor,
    Alignment? alignment,
    VoidCallback? onTap}) =>
      KayleeRoundBorder(
        borderRadius: borderRadius,
        borderColor: ColorsRes.hyper,
        borderWidth: borderWidth,
        padding: padding,
        child: child,
        width: width,
        height: height,
        bgColor: bgColor,
        alignment: alignment,
        onTap: onTap,
      );

  factory KayleeRoundBorder.normal({BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? padding,
    Widget? child,
    double? width,
    double? height,
    Color? bgColor,
    Alignment? alignment,
    VoidCallback? onTap}) =>
      KayleeRoundBorder(
        borderRadius: borderRadius,
        borderColor: ColorsRes.textFieldBorder,
        borderWidth: borderWidth,
        padding: padding,
        child: child,
        width: width,
        height: height,
        bgColor: bgColor,
        alignment: alignment,
        onTap: onTap,
      );

  final BorderRadius? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? bgColor;
  final Alignment? alignment;

  const KayleeRoundBorder({Key? key,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.onTap,
    this.padding,
    this.child,
    this.width,
    this.height,
    this.bgColor,
    this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(Dimens.px5),
        side: BorderSide(
          width: borderWidth ?? Dimens.px1,
          color: borderColor ?? ColorsRes.hyper,
        ),
      ),
      color: bgColor ?? Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: padding ?? EdgeInsets.zero,
          alignment: alignment,
          height: height,
          width: width,
          child: child ?? Container(),
        ),
      ),
    );
  }
}
