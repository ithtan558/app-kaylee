import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class TextStyles {
  static final TextStyle hyper = TextStyle(color: ColorsRes.hyper);
  static final TextStyle hint = TextStyle(color: ColorsRes.hintText);
  static final TextStyle normal = TextStyle(color: ColorsRes.text);
  static final TextStyle normalWhite = TextStyle(color: Colors.white);

  static final TextStyle _w400 = TextStyle(fontWeight: FontWeight.w400);
  static final TextStyle _w500 = TextStyle(fontWeight: FontWeight.w500);
  static final TextStyle _w700 = TextStyle(fontWeight: FontWeight.w700);

  static final TextStyle _f12 = TextStyle(fontSize: Dimens.px12);
  static final TextStyle _f16 = TextStyle(fontSize: Dimens.px16);
  static final TextStyle _f18 = TextStyle(fontSize: Dimens.px18);
  static final TextStyle _f26 = TextStyle(fontSize: Dimens.px26);

  static final TextStyle hyper16W400 = hyper.merge(_f16.merge(_w400));
  static final TextStyle hyper16W500 = hyper.merge(_f16.merge(_w500));
  static final TextStyle hyper18W700 = hyper.merge(_f18.merge(_w700));

  static final TextStyle normal12W400 = normal.merge(_f12.merge(_w400));
  static final TextStyle normal16W400 = normal.merge(_f16.merge(_w400));
  static final TextStyle normal16W500 = normal.merge(_f16.merge(_w500));
  static final TextStyle normal18W700 = normal.merge(_f18.merge(_w700));
  static final TextStyle normal26W700 = normal.merge(_f26.merge(_w700));

  static final TextStyle normalWhite12W400 =
      normalWhite.merge(_f12.merge(_w400));
  static final TextStyle normalWhite16W500 =
      normalWhite.merge(_f16.merge(_w500));
  static final TextStyle normalWhite18W700 =
      normalWhite.merge(_f18.merge(_w700));

  static final TextStyle hint16W400 = hint.merge(_f16.merge(_w400));
}
