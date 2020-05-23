import 'dart:math';

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
          {Function onPress, Color background, Widget child}) =>
      KayleeFlatButton(
        onPress: onPress,
        borderRadius: BorderRadius.circular(Dimens.px10),
        background: background,
        child: child,
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
                  child: Text(title ?? '',
                      style: ScreenUtils.textTheme(context).bodyText2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )))),
    );
  }
}

class KayleeDateFilterButton extends StatefulWidget {
  KayleeDateFilterButton();

  @override
  _KayleeDateFilterButtonState createState() =>
      new _KayleeDateFilterButtonState();
}

class _KayleeDateFilterButtonState extends BaseState<KayleeDateFilterButton>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate;

  AnimationController animController;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeFlatButton.filter(
      child: Row(children: [
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: Text(
              'Tháng ${DateFormat(' ${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}').format(selectedDate)}',
              style: theme.textTheme.bodyText2.copyWith(
                color: Colors.white,
              )),
        )),
        AnimatedBuilder(
          animation: animController,
          builder: (context, child) {
            return Transform.rotate(
                angle: pi * animController.value, child: child);
          },
          child: Image.asset(
            Images.ic_filter_down,
            color: Colors.white,
            width: Dimens.px16,
            height: Dimens.px16,
          ),
        )
      ]),
      onPress: () {
        if (animController.status == AnimationStatus.completed ||
            animController.status == AnimationStatus.forward)
          animController.reverse(from: animController.value);
        else if (animController.status == AnimationStatus.dismissed ||
            animController.status == AnimationStatus.reverse)
          animController.forward(from: animController.value);
      },
    );
  }
}
