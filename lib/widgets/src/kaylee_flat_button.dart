import 'dart:math';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeFlatButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String? title;
  final Widget? child;
  final Color? background;
  final BorderRadius? borderRadius;
  final EdgeInsets? titlePadding;

  KayleeFlatButton(
      {this.onPress,
      this.title,
      this.child,
      this.background,
      this.borderRadius,
      this.titlePadding});

  factory KayleeFlatButton.normal({String? title, VoidCallback? onPress}) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        borderRadius: BorderRadius.circular(Dimens.px5),
      );

  factory KayleeFlatButton.withTextField(
          {String? title, VoidCallback? onPress}) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        borderRadius: BorderRadius.circular(Dimens.px5),
        titlePadding: EdgeInsets.symmetric(horizontal: Dimens.px14),
      );

  factory KayleeFlatButton.withLabelDivider(
          {String? title, VoidCallback? onPress}) =>
      KayleeFlatButton(
        title: title,
        onPress: onPress,
        borderRadius: BorderRadius.circular(Dimens.px5),
        titlePadding: EdgeInsets.symmetric(horizontal: Dimens.px16),
      );

  factory KayleeFlatButton.filter(
          {VoidCallback? onPress, Color? background, Widget? child}) =>
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
          child: child != null
              ? child!
              : KayleeText(
                  title ?? '',
                  style: TextStyles.normalWhite16W500,
                  maxLines: 1,
                )),
    );
  }
}

class KayleeDateFilterButton extends StatefulWidget {
  final AsyncValueGetter<bool> onTap;
  final DateTime selectedDate;
  final Color? color;

  KayleeDateFilterButton({
    required this.selectedDate,
    required this.onTap,
    this.color,
  });

  @override
  _KayleeDateFilterButtonState createState() => _KayleeDateFilterButtonState();
}

class _KayleeDateFilterButtonState extends BaseState<KayleeDateFilterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
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
      background: widget.color,
      child: Row(children: [
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: KayleeText.normalWhite16W400(
            'Tháng ${DateFormat('${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}').format(widget.selectedDate)}',
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
        final result = await widget.onTap();
        if (animController.isCompleted && result)
          animController.reverse(from: animController.value);
      },
    );
  }
}
