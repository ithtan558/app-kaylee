import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

enum DateRangeValue {
  thisWeek,
  lastWeek,
  custom,
}

class KayleeDateRangePickerView extends StatefulWidget {
  @override
  _KayleeDateRangePickerViewState createState() =>
      _KayleeDateRangePickerViewState();
}

class _KayleeDateRangePickerViewState
    extends KayleeState<KayleeDateRangePickerView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.px24),
          child: KayleeText.normal18W700(
            Strings.chonThoiGian,
            textAlign: TextAlign.center,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
            color: ColorsRes.divider,
            width: Dimens.px1,
          ))),
          padding: const EdgeInsets.all(Dimens.px16),
          child: Row(
            children: [
              Expanded(
                child: KayLeeRoundedButton.button2(
                  margin: EdgeInsets.zero,
                  text: Strings.huy,
                  onPressed: popScreen,
                ),
              ),
              SizedBox(width: Dimens.px8),
              Expanded(
                child: KayLeeRoundedButton.normal(
                  margin: EdgeInsets.zero,
                  text: Strings.luu,
                  onPressed: () {
                    primaryFocus.unfocus();
                    popScreen();
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

extension DateRangeValueExtension on DateRangeValue {
  DateTimeRange get range {
    switch (this) {
      case DateRangeValue.thisWeek:
        return DateTimeRange(start: DateTime.now(), end: DateTime.now());
      case DateRangeValue.lastWeek:
        return DateTimeRange(start: DateTime.now(), end: DateTime.now());
      default:
        return null;
    }
  }
}
