import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

const int _kDefaultAmountMin = 1;

class KayleeIncrAndDecrButtons extends StatefulWidget {
  final int? initAmount;
  final int? amountMin;
  final int? amountMax;
  final ValueSetter<int>? onAmountChange;
  final Color? btnBgColor;
  final Color? btnIconColor;

  const KayleeIncrAndDecrButtons(
      {Key? key,
      this.initAmount,
      this.onAmountChange,
      this.amountMin,
      this.amountMax,
      this.btnBgColor,
      this.btnIconColor})
      : super(key: key);

  @override
  _KayleeIncrAndDecrButtonsState createState() =>
      _KayleeIncrAndDecrButtonsState();
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
    final decrBtnColor = widget.btnBgColor ??
        (current == (widget.amountMin ?? _kDefaultAmountMin)
            ? ColorsRes.button1
            : ColorsRes.button);
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (current > (widget.amountMin ?? _kDefaultAmountMin)) {
              setState(() {
                current--;
                widget.onAmountChange?.call(current);
              });
            }
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: Dimens.px32,
            height: Dimens.px32,
            decoration: BoxDecoration(
              color: widget.btnBgColor ?? Colors.white,
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                  BorderSide(color: decrBtnColor, width: 1.5)),
            ),
            child: Icon(
              Icons.remove,
              color: widget.btnIconColor ?? decrBtnColor,
              size: Dimens.px16,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
          child: KayleeText.normal16W500(
            '$current',
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (widget.amountMax == null || current < widget.amountMax!) {
              setState(() {
                current++;
                widget.onAmountChange?.call(current);
              });
            }
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: Dimens.px32,
            height: Dimens.px32,
            decoration: BoxDecoration(
              color: widget.btnBgColor ?? Colors.white,
              shape: BoxShape.circle,
              border: const Border.fromBorderSide(
                  BorderSide(color: ColorsRes.button, width: 1.5)),
            ),
            child: Icon(
              Icons.add,
              color: widget.btnIconColor ?? ColorsRes.button,
              size: Dimens.px16,
            ),
          ),
        ),
      ],
    );
  }
}
