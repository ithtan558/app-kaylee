import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class TextStyles {
  static const TextStyle hyper = TextStyle(color: ColorsRes.hyper);
  static const TextStyle hint = TextStyle(color: ColorsRes.hintText);
  static const TextStyle normal = TextStyle(color: ColorsRes.text);
  static const TextStyle normalWhite = TextStyle(color: Colors.white);
  static const TextStyle button = TextStyle(color: ColorsRes.button);
  static const TextStyle error = TextStyle(color: ColorsRes.errorText);
  static const TextStyle textFieldBorder =
      TextStyle(color: ColorsRes.textFieldBorder);

  static const TextStyle _w400 = TextStyle(fontWeight: FontWeight.w400);
  static const TextStyle _w500 = TextStyle(fontWeight: FontWeight.w500);
  static const TextStyle _w700 = TextStyle(fontWeight: FontWeight.w700);

  static const TextStyle _f12 = TextStyle(fontSize: Dimens.px12);
  static const TextStyle _f16 = TextStyle(fontSize: Dimens.px16);
  static const TextStyle _f18 = TextStyle(fontSize: Dimens.px18);
  static const TextStyle _f26 = TextStyle(fontSize: Dimens.px26);

  static final TextStyle hyper16W400 = hyper.merge(_f16.merge(_w400));
  static final TextStyle hyper16W500 = hyper.merge(_f16.merge(_w500));
  static final TextStyle hyper16W700 = hyper.merge(_f16.merge(_w700));
  static final TextStyle hyper18W700 = hyper.merge(_f18.merge(_w700));

  static final TextStyle normal12W400 = normal.merge(_f12.merge(_w400));
  static final TextStyle normal16W400 = normal.merge(_f16.merge(_w400));
  static final TextStyle normal16W500 = normal.merge(_f16.merge(_w500));
  static final TextStyle normal18W700 = normal.merge(_f18.merge(_w700));
  static final TextStyle normal26W700 = normal.merge(_f26.merge(_w700));

  static final TextStyle normalWhite12W400 =
      normalWhite.merge(_f12.merge(_w400));
  static final TextStyle normalWhite16W400 =
      normalWhite.merge(_f16.merge(_w400));
  static final TextStyle normalWhite16W500 =
      normalWhite.merge(_f16.merge(_w500));
  static final TextStyle normalWhite18W700 =
      normalWhite.merge(_f18.merge(_w700));

  static final TextStyle hint16W400 = hint.merge(_f16.merge(_w400));
  static final TextStyle hint16W500 = hint.merge(_f16.merge(_w500));

  static final TextStyle button16W400 = button.merge(_f16.merge(_w400));
  static final TextStyle button16W500 = button.merge(_f16.merge(_w500));

  static final TextStyle error12W400 = error.merge(_f12.merge(_w400));
  static final TextStyle error16W500 = error.merge(_f16.merge(_w500));

  static final TextStyle textFieldBorder12W400 =
      textFieldBorder.merge(_f12.merge(_w400));
}
