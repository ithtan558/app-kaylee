import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeQuantitySlider extends StatefulWidget {
  final String? title;
  final QuantitySliderController? controller;

  const KayleeQuantitySlider({Key? key, this.title, this.controller})
      : super(key: key);

  @override
  _KayleeQuantitySliderState createState() => _KayleeQuantitySliderState();
}

class _KayleeQuantitySliderState extends State<KayleeQuantitySlider> {
  final minQuantity = 1;
  final maxQuantity = 10;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(bottom: Dimens.px16),
            child: KayleeText.normal16W500(widget.title!),
          ),
        Row(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(
                  sliderTheme: SliderThemeData(
                    trackHeight: Dimens.px4,
                    activeTrackColor: ColorsRes.hintText,
                    valueIndicatorColor: ColorsRes.hyper,
                    thumbColor: ColorsRes.hyper,
                    overlayColor: ColorsRes.hyper.withOpacity(0.12),
                    inactiveTrackColor: ColorsRes.textFieldBorder,
                  ),
                ),
                child: Slider(
                  divisions: maxQuantity,
                  onChanged: (value) {
                    widget.controller?.quantity = value.toInt();
                    setState(() {});
                  },
                  onChangeEnd: (value) {
                    widget.controller?.quantity = value.toInt();
                  },
                  min: minQuantity.toDouble(),
                  max: maxQuantity.toDouble(),
                  value:
                  (widget.controller?.quantity ?? minQuantity).toDouble(),
                ),
              ),
            ),
            KayleeRoundBorder(
              child: KayleeText.normal16W400(
                  '${widget.controller?.quantity ?? minQuantity}'),
              borderColor: ColorsRes.divider,
              alignment: Alignment.center,
              width: Dimens.px48,
              height: Dimens.px48,
            )
          ],
        ),
      ],
    );
  }
}

class QuantitySliderController {
  late int _quantity;

  int get quantity => _quantity;

  set quantity(value) {
    _quantity = value;
  }

  QuantitySliderController({int quantity = 1}) {
    this.quantity = quantity;
  }
}
