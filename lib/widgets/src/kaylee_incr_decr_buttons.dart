import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

const int _kDefaultAmountMin = 1;

class KayleeIncrAndDecrButtons extends StatefulWidget {
  final int initAmount;
  final int amountMin;
  final int amountMax;
  final ValueSetter<int> onAmountChange;

  KayleeIncrAndDecrButtons(
      {this.initAmount, this.onAmountChange, this.amountMin, this.amountMax});

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
    current = widget.initAmount ?? (widget.amountMin ?? _kDefaultAmountMin);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decrBtnColor = current == (widget.amountMin ?? _kDefaultAmountMin)
        ? ColorsRes.button1
        : ColorsRes.button;
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (current > (widget.amountMin ?? _kDefaultAmountMin))
              setState(() {
                current--;
                if (widget.onAmountChange.isNotNull)
                  widget.onAmountChange(current);
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
                  BorderSide(color: decrBtnColor, width: 1.5)),
            ),
            child: Icon(
              Icons.remove,
              color: decrBtnColor,
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
            if (widget.amountMax.isNull || current < widget.amountMax)
              setState(() {
                current++;
                if (widget.onAmountChange.isNotNull)
                  widget.onAmountChange(current);
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
