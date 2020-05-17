import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/colors_res.dart';

class HyperLinkText extends StatelessWidget {
  final String text;
  final void Function() onTap;

  HyperLinkText({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Text(text ?? '',
            style:
                ScreenUtils.screenTheme(context).textTheme.bodyText2.copyWith(
                      color: ColorsRes.hyper,
                      fontWeight: FontWeight.w400,
                    )),
      ),
    );
  }
}
