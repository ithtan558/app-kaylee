import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/colors_res.dart';
import 'package:kaylee/res/dimens.dart';
import 'package:kaylee/res/strings.dart';
import 'package:kaylee/screens/signup/signup_screen.dart';

export 'src/hyper_link_text.dart';
export 'src/kaylee_appbar.dart';
export 'src/kaylee_rounded_button.dart';
export 'src/kaylee_tex.dart';
export 'src/kaylee_text_field.dart';
export 'src/policy_checkbox.dart';

class Go2RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = ScreenUtils.screenTheme(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.chuaCoTK,
          style: textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: Dimens.px8),
          child: GestureDetector(
            onTap: () {
              push(PageIntent(context, SignUpScreen));
            },
            child: Container(
              color: Colors.transparent,
              child: Text(Strings.dangKy,
                  style: textTheme.bodyText2.copyWith(
                    color: ColorsRes.hyper,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
