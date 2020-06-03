import 'dart:math';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

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
          padding: titlePadding ??
              const EdgeInsets.symmetric(horizontal: Dimens.px8),
          color: background ?? ColorsRes.hyper,
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(Dimens.px5)),
          clipBehavior: Clip.antiAlias,
          child: child.isNotNull
              ? child
              : KayleeText(
                  title ?? '',
                  style: TextStyles.normalWhite16W500,
                  maxLines: 1,
                )),
    );
  }
}

class KayleeDateFilterButton extends StatefulWidget {
  final void Function() onDateSelected;

  KayleeDateFilterButton({this.onDateSelected});

  @override
  _KayleeDateFilterButtonState createState() => _KayleeDateFilterButtonState();
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
          child: KayleeText.normalWhite16W400(
            'Tháng ${DateFormat('${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}').format(selectedDate)}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )),
        AnimatedBuilder(
          animation: animController,
          builder: (context, child) {
            return Transform.rotate(
                angle: pi * animController.value, child: child);
          },
          child: Image.asset(
            Images.ic_triangle_down,
            color: Colors.white,
            width: Dimens.px16,
            height: Dimens.px16,
          ),
        )
      ]),
      onPress: () async {
        if (animController.isDismissed)
          animController.forward(from: animController.value);

        await showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            barrierColor: ColorsRes.shadow.withOpacity(0.1),
            builder: (context) {
              return Container(
                height: 215.0 + Dimens.px44,
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
                        height: Dimens.px44, alignment: Alignment.centerRight),
                    Container(
                      height: 215.0,
                      child: KayleeMonthYearPicker(
                        maximumDate: DateTime(
                            DateTime
                                .now()
                                .year, DateTime
                            .now()
                            .month, 1),
                        initialDateTime: selectedDate,
                        onDateTimeChanged: (changed) {
                          setState(() {
                            selectedDate = changed;
                          });
                        },
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            });
        if (animController.isCompleted)
          animController.reverse(from: animController.value);
      },
    );
  }
}
