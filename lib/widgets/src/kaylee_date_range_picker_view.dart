import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

enum DateRangeValueType {
  thisWeek,
  lastWeek,
  thisMonth,
  lastMonth,
}

extension DateRangeValueTypeExtension on DateRangeValueType {
  String? get text {
    switch (this) {
      case DateRangeValueType.thisWeek:
        return Strings.tuanNay;
      case DateRangeValueType.lastWeek:
        return Strings.tuanTruoc;
      case DateRangeValueType.thisMonth:
        return Strings.thangNay;
      case DateRangeValueType.lastMonth:
        return Strings.thangTruoc;
      default:
        return null;
    }
  }

  DateTimeRange get range {
    switch (this) {
      case DateRangeValueType.thisWeek:
        final now = DateTime.now();
        final startDate = now.subtract(Duration(days: now.weekday - 1));
        final endDate = startDate.add(Duration(days: 6));
        return DateTimeRange(start: startDate, end: endDate);
      case DateRangeValueType.lastWeek:
        final now = DateTime.now();
        final startDate = now.subtract(Duration(days: 7 + now.weekday - 1));
        final endDate = startDate.add(Duration(days: 6));
        return DateTimeRange(start: startDate, end: endDate);
      case DateRangeValueType.thisMonth:
        final now = DateTime.now();
        final startDate = now.findFirstDayOfMonthOfCurrent();
        final endDate = now.findLastDateOfMonthOfCurrent();
        return DateTimeRange(start: startDate, end: endDate);
      case DateRangeValueType.lastMonth:
        final now = DateTime.now();
        final startDate = now.findFirstDayOfLastMonthFromCurrent();
        final endDate = now.findLastDateOfLastMonthFromCurrent();
        return DateTimeRange(start: startDate, end: endDate);
      default:
        return DateTimeRange(start: DateTime.now(), end: DateTime.now());
    }
  }
}

class KayleeDateRangePickerView extends StatefulWidget {
  final ValueChanged<DateTimeRange>? onSelectByDate;
  final ValueChanged<DateRangeValueType>? onSelectByType;
  final DateTimeRange selectedRange;
  final DateRangeValueType? selectedType;

  KayleeDateRangePickerView(
      {required this.selectedRange,
      this.onSelectByDate,
      this.onSelectByType,
      this.selectedType});

  @override
  _KayleeDateRangePickerViewState createState() =>
      _KayleeDateRangePickerViewState();
}

class _KayleeDateRangePickerViewState
    extends KayleeState<KayleeDateRangePickerView> {
  DateRangeValueType? rangeValueType;
  late DateTimeRange dateRange;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    rangeValueType = widget.selectedType;
    if (rangeValueType != null) {
      dateRange = rangeValueType!.range;
    } else {
      dateRange = widget.selectedRange;
    }
  }

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
              .copyWith(bottom: Dimens.px16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px16),
                child: KayleeText.normal16W500(
                  Strings.chonNhanh,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px24),
                child: Container(
                  height: Dimens.px32,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = DateRangeValueType.values.elementAt(index);
                        return _buildTag(
                            title: item.text ?? '',
                            onTap: () {
                              _onChangeType(type: item);
                            },
                            selected: rangeValueType == item);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            width: Dimens.px16,
                          ),
                      itemCount: DateRangeValueType.values.length),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px8),
                child: KayleeText.normal16W500(
                  Strings.chonTheoNgay,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  _buildPicker(
                    date: dateRange.start,
                    onTap: () {
                      showKayleeDatePickerDialog(
                        context: context,
                        initialDateTime: dateRange.start,
                        maximumDate: dateRange.end,
                        onDone: () {
                          if (selectedStartDate != null) {
                            dateRange = DateTimeRange(
                                start: selectedStartDate!, end: dateRange.end);
                            selectedStartDate = null;
                            rangeValueType = null;
                            setState(() {});
                          }
                        },
                        onDismiss: () {
                          selectedStartDate = null;
                        },
                        onDateTimeChanged: (changed) {
                          selectedStartDate = changed;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    width: Dimens.px8,
                  ),
                  _buildPicker(
                    date: dateRange.end,
                    onTap: () {
                      showKayleeDatePickerDialog(
                        context: context,
                        initialDateTime: dateRange.end,
                        maximumDate: DateTime.now(),
                        onDone: () {
                          if (selectedEndDate != null) {
                            if (selectedEndDate!
                                    .difference(dateRange.start)
                                    .inDays <
                                0) {
                              dateRange = DateTimeRange(
                                  start: selectedEndDate!,
                                  end: selectedEndDate!);
                            } else {
                              dateRange = DateTimeRange(
                                  start: dateRange.start,
                                  end: selectedEndDate!);
                            }
                            selectedEndDate = null;
                            rangeValueType = null;
                            setState(() {});
                          }
                        },
                        onDismiss: () {
                          selectedEndDate = null;
                        },
                        onDateTimeChanged: (changed) {
                          selectedEndDate = changed;
                        },
                      );
                    },
                  ),
                ],
              )
            ],
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
                    popScreen();
                    if (rangeValueType != null) {
                      widget.onSelectByType?.call(rangeValueType!);
                    } else {
                      widget.onSelectByDate?.call(dateRange);
                    }
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _onChangeType({required DateRangeValueType type}) {
    setState(() {
      rangeValueType = type;
      dateRange = rangeValueType!.range;
    });
  }

  Widget _buildTag(
      {required String title,
      required VoidCallback onTap,
      bool selected = false}) {
    return selected
        ? KayleeRoundBorder.hyper(
            borderWidth: Dimens.px2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: KayleeText.normal12W400(
                title,
                maxLines: 1,
              ),
            ),
            onTap: onTap,
          )
        : KayleeRoundBorder(
            borderColor: ColorsRes.textFieldBorder,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: KayleeText.normal12W400(
                title,
                maxLines: 1,
              ),
            ),
            onTap: onTap,
          );
  }

  Widget _buildPicker({DateTime? date, VoidCallback? onTap}) {
    return Expanded(
      child: KayleeRoundBorder.normal(
        padding: const EdgeInsets.only(left: Dimens.px12, right: Dimens.px8),
        child: Row(
          children: [
            Expanded(
              child: KayleeDateTimeText.dayMonthYear(
                date,
                textStyle: TextStyles.normal16W400,
              ),
            ),
            Container(
              width: Dimens.px1,
              height: Dimens.px40,
              color: ColorsRes.textFieldBorder,
              margin: const EdgeInsets.symmetric(
                vertical: Dimens.px4,
              ).copyWith(left: Dimens.px12, right: Dimens.px8),
            ),
            Image.asset(
              Images.ic_calendar,
              width: Dimens.px16,
              height: Dimens.px16,
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
