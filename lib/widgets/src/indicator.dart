import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class Indicator extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final IndicatorController controller;
  final ValueChanged<int>? onSelect;

  const Indicator({
    Key? key,
    this.activeColor = ColorsRes.background,
    this.inactiveColor = ColorsRes.hintText,
    required this.controller,
    this.onSelect,
  }) : super(key: key);

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> implements _IndicatorView {
  @override
  void initState() {
    super.initState();
    widget.controller._view = this;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.controller.length, (index) {
        return Padding(
          padding: EdgeInsets.only(
              right: (widget.controller.length - 1 == 0) ||
                      index == widget.controller.length - 1
                  ? 0
                  : Dimens.px8),
          child: _buildDot(
              onTap: () {}, selected: index == widget.controller.selected),
        );
      }),
    );
  }

  @override
  void jumpTo({required int index}) {
    setState(() {
      widget.controller.selected = index;
    });
    widget.onSelect?.call(index);
  }

  Widget _buildDot({VoidCallback? onTap, bool selected = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        clipBehavior: Clip.antiAlias,
        type: MaterialType.circle,
        color: selected ? widget.activeColor : widget.inactiveColor,
        child: const SizedBox(
          width: 8,
          height: 8,
        ),
      ),
    );
  }
}

class IndicatorController implements _IndicatorView {
  int selected;
  int length;
  late _IndicatorView _view;

  IndicatorController({this.length = 0, this.selected = 0});

  @override
  void jumpTo({required int index}) {
    _view.jumpTo(index: index);
  }
}

abstract class _IndicatorView {
  void jumpTo({required int index});
}
