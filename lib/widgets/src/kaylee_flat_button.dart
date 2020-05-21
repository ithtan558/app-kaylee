import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeFlatButton extends StatelessWidget {
  final Function() onPress;
  final String title;
  final Widget child;
  final Color background;
  final BorderRadius borderRadius;
  final EdgeInsets titlePadding;

  KayleeFlatButton(
      {this.onPress,
      this.title,
      this.child,
      this.background,
      this.borderRadius,
      this.titlePadding});

  factory KayleeFlatButton.normal({String title, Function onPress}) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        borderRadius: BorderRadius.circular(Dimens.px5),
      );

  factory KayleeFlatButton.withLabelDivider({String title, Function onPress}) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        borderRadius: BorderRadius.circular(Dimens.px5),
        titlePadding: EdgeInsets.symmetric(horizontal: Dimens.px16),
      );

  factory KayleeFlatButton.filter(
          {String title, Function onPress, Color background}) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        borderRadius: BorderRadius.circular(Dimens.px10),
        background: background,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px40,
      child: FlatButton(
          onPressed: onPress,
          color: background ?? ColorsRes.hyper,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          clipBehavior: Clip.antiAlias,
          child: child.isNotNull
              ? child
              : Padding(
                  padding: titlePadding ??
                      EdgeInsets.symmetric(horizontal: Dimens.px14),
                  child: Text(title,
                      style: ScreenUtils.screenTheme(context)
                          .textTheme
                          .bodyText2
                          .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )))),
    );
  }
}
