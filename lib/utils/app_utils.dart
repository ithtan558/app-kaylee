import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

Future showDateTimePopup(
    {@required BuildContext context, @required WidgetBuilder builder}) {
  final screenHeight = ScreenUtils.screenSize(context).height;
  return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: screenHeight * 258 / 667,
          decoration: BoxDecoration(
            color: ColorsRes.dialogNavigate,
            boxShadow: [
              BoxShadow(
                  color: ColorsRes.shadow,
                  offset: Offset(0, -0.5),
                  blurRadius: 0,
                  spreadRadius: 0)
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                  height: screenHeight * Dimens.px44 / 667,
                  alignment: Alignment.centerRight),
              Container(
                height: screenHeight * 214 / 667,
                child: builder(context),
              ),
            ],
          ),
        );
      });
}
