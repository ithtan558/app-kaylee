import 'dart:ui' as ui;

import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

abstract class KayleePriceRangeView {
  void reset();
}

class KayleePriceRange extends StatefulWidget {
  final String title;
  final KayleePriceRangeController controller;

  KayleePriceRange({this.title = Strings.gia, this.controller});

  @override
  _KayleePriceRangeState createState() => _KayleePriceRangeState();
}

class _KayleePriceRangeState extends BaseState<KayleePriceRange>
    implements KayleePriceRangeView {
  RangeValues rangeValues;
  final double min = 0, max = 100000000;

  @override
  void initState() {
    super.initState();
    widget.controller?._view = this;
    rangeValues = RangeValues(widget.controller?.startPrice?.toDouble() ?? min,
        widget.controller?.endPrice?.toDouble() ?? max);
  }

  @override
  void reset() {
    setState(() {
      rangeValues = RangeValues(min, max);
      widget.controller?.startPrice = null;
      widget.controller?.endPrice = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotNullAndEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: Dimens.px16),
            child: KayleeText.normal16W500(widget.title),
          ),
        Theme(
          data: ThemeData(
            sliderTheme: SliderThemeData(
              trackHeight: Dimens.px4,
              activeTrackColor: ColorsRes.hintText,
              valueIndicatorColor: ColorsRes.hyper,
              thumbColor: ColorsRes.hyper,
              overlayColor: ColorsRes.hyper.withOpacity(0.12),
              inactiveTrackColor: ColorsRes.textFieldBorder,
              thumbShape: _CustomThumbShape(),
            ),
          ),
          child: RangeSlider(
            onChanged: (RangeValues value) {
              rangeValues = value;
              setState(() {});
            },
            min: min,
            max: max,
            divisions: 10000,
            labels: RangeLabels(
                CurrencyUtils.formatVNDWithCustomUnit(rangeValues.start),
                CurrencyUtils.formatVNDWithCustomUnit(rangeValues.end)),
            onChangeEnd: (value) {
              widget.controller?.startPrice = value.start.toInt();
              widget.controller?.endPrice = value.end.toInt();
            },
            values: rangeValues,
          ),
        ),
      ],
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(Dimens.px32, Dimens.px32);

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      ui.TextDirection textDirection,
      double value}) {}
}

class KayleePriceRangeController {
  int startPrice;
  int endPrice;
  KayleePriceRangeView _view;

  void reset() {
    _view?.reset();
  }
}
