import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/dimens.dart';

class KayLeeRoundedButton extends StatelessWidget {
  final double width;
  final String text;
  final void Function() onPressed;
  final EdgeInsets margin;
  final BorderSide borderSide;
  final Color color;

  factory KayLeeRoundedButton.button2(
          {String text,
          EdgeInsets margin,
          void Function() onPressed,
          double width}) =>
      KayLeeRoundedButton(
        text: text,
        margin: margin,
        onPressed: onPressed,
        width: width,
        borderSide: BorderSide(
          width: Dimens.px1,
          color: ColorsRes.text,
        ),
        color: ColorsRes.hintText,
      );

  factory KayLeeRoundedButton.button3(
          {String text,
          EdgeInsets margin,
          void Function() onPressed,
          double width}) =>
      KayLeeRoundedButton(
        text: text,
        margin: margin,
        onPressed: onPressed,
        width: width,
        color: ColorsRes.button1,
      );

  factory KayLeeRoundedButton.normal(
          {String text,
          EdgeInsets margin,
          void Function() onPressed,
          double width}) =>
      KayLeeRoundedButton(
        text: text,
        margin: margin,
        onPressed: onPressed,
        width: width,
      );

  KayLeeRoundedButton(
      {this.width,
      this.text,
      this.onPressed,
      this.margin,
      this.borderSide,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px48,
      width: width.isNotNull ? width : double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: FlatButton(
        onPressed: onPressed,
        shape: StadiumBorder(side: borderSide ?? BorderSide.none),
        color: color ?? ColorsRes.button,
        child: Text(text ?? '', style: TextStyles.normalWhite16W500),
      ),
    );
  }
}
