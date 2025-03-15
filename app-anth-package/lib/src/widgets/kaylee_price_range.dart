import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

abstract class KayleePriceRangeView {
  void reset();
}

class KayleePriceRange extends StatefulWidget {
  final String title;
  final KayleePriceRangeController? controller;
  final VoidCallback? onChanged;

  const KayleePriceRange({
    Key? key,
    this.title = '',
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _KayleePriceRangeState createState() => _KayleePriceRangeState();
}

class _KayleePriceRangeState extends BaseState<KayleePriceRange>
    implements KayleePriceRangeView {
  late SfRangeValues rangeValues;
  final double min = 0, max = 10000000;

  @override
  void initState() {
    super.initState();
    widget.controller?._view = this;
    rangeValues = SfRangeValues(
        widget.controller?.startPrice?.toDouble() ?? min,
        widget.controller?.endPrice?.toDouble() ?? max);
  }

  @override
  void reset() {
    setState(() {
      rangeValues = SfRangeValues(min, max);
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
        SfRangeSliderTheme(
          data: SfRangeSliderThemeData(
            activeTrackHeight: Dimens.px4,
            inactiveTrackHeight: Dimens.px4,
            activeTrackColor: ColorsRes.hintText,
            tooltipBackgroundColor: ColorsRes.hyper,
            thumbColor: ColorsRes.hyper,
            overlayColor: ColorsRes.hyper.withOpacity(0.12),
            inactiveTrackColor: ColorsRes.textFieldBorder,
          ),
          child: SfRangeSlider(
            onChanged: (SfRangeValues value) {
              widget.controller?.startPrice = value.start.toInt();
              widget.controller?.endPrice = value.end.toInt();
              widget.onChanged?.call();
              setState(() {
                rangeValues = value;
              });
            },
            values: rangeValues,
            min: min,
            max: max,
            enableTooltip: true,
            stepSize: 10000,
            tooltipTextFormatterCallback: (actualValue, _) =>
                CurrencyUtils.formatVNDWithCustomUnit(actualValue),
          ),
        ),
      ],
    );
  }
}

class KayleePriceRangeController {
  int? startPrice;
  int? endPrice;
  KayleePriceRangeView? _view;

  void reset() {
    _view?.reset();
  }
}
