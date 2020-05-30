import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeIncrAndDecrButtons extends StatefulWidget {
  @override
  _KayleeIncrAndDecrButtonsState createState() =>
      new _KayleeIncrAndDecrButtonsState();
}

class _KayleeIncrAndDecrButtonsState
    extends BaseState<KayleeIncrAndDecrButtons> {
  int current = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (current > 1)
              setState(() {
                current--;
              });
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: Dimens.px32,
            height: Dimens.px32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                  BorderSide(color: ColorsRes.button1, width: 1.5)),
            ),
            child: Icon(
              Icons.remove,
              color: ColorsRes.button1,
              size: Dimens.px16,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.px16),
          child: KayleeText.normal16W500(
            '$current',
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              current++;
            });
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: Dimens.px32,
            height: Dimens.px32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                  BorderSide(color: ColorsRes.button, width: 1.5)),
            ),
            child: Icon(
              Icons.add,
              color: ColorsRes.button,
              size: Dimens.px16,
            ),
          ),
        ),
      ],
    );
  }
}
