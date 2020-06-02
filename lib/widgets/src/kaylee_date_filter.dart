import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/kaylee_flat_button.dart';

class DateFilter extends StatefulWidget {
  @override
  _DateFilterState createState() => new _DateFilterState();
}

class _DateFilterState extends BaseState<DateFilter> {
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Dimens.px16,
            right: Dimens.px16,
            top: Dimens.px8,
            bottom: Dimens.px8,
          ),
          child: KayleeDateFilterButton(),
        ),
      ],
    );
  }
}
