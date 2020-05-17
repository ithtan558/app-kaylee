import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/dimens.dart';


class KayLeeRoundedButton extends StatelessWidget {
  final double width;
  final String text;
  final void Function() onPressed;
  final EdgeInsets margin;

  KayLeeRoundedButton({this.width, this.text, this.onPressed, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px48,
      width: width.isNotNull ? width : double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: FlatButton(
        onPressed: onPressed,
        shape: const StadiumBorder(),
        color: ColorsRes.button,
        child: Text(text ?? '',
            style:
            ScreenUtils.screenTheme(context).textTheme.bodyText2.copyWith(
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}