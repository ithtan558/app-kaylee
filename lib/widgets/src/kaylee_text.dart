import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeDatePickerText extends StatefulWidget {
  final ValueChanged<DateTimeRange>? onSelectRange;
  final KayleeDatePickerTextController? controller;
  final double textSize;

  const KayleeDatePickerText(
      {Key? key,
      this.controller,
      this.onSelectRange,
      this.textSize = Dimens.px16})
      : super(key: key);

  @override
  _KayleeDatePickerTextState createState() => _KayleeDatePickerTextState();
}

class _KayleeDatePickerTextState extends BaseState<KayleeDatePickerText> {
  late DateTimeRange dateRange;
  DateRangeValueType? rangeType;

  @override
  void initState() {
    super.initState();
    dateRange = widget.controller?.value ??
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return KayleeDateRangeText(
      textSize: widget.textSize,
      fromDate: dateRange.start,
      toDate: dateRange.end,
      onTap: () {
        showKayleeDialog(
          context: context,
          child: KayleeDateRangePickerView(
            selectedRange: dateRange,
            selectedType: rangeType,
            onSelectByType: (value) {
              rangeType = value;
              _selectDateRange(rangeType!.range);
            },
            onSelectByDate: (value) {
              rangeType = null;
              _selectDateRange(value);
            },
          ),
        );
      },
    );
  }

  void _selectDateRange(DateTimeRange value) {
    dateRange = value;
    widget.controller?.value = dateRange;
    setState(() {});
    widget.onSelectRange?.call(dateRange);
  }
}

class KayleeDateRangePickerText extends StatefulWidget {
  final void Function(DateTime from, DateTime to)? onSelect;

  const KayleeDateRangePickerText({Key? key, this.onSelect}) : super(key: key);

  @override
  _KayleeDateRangePickerTextState createState() =>
      _KayleeDateRangePickerTextState();
}

class _KayleeDateRangePickerTextState
    extends BaseState<KayleeDateRangePickerText> {
  final now = DateTime.now();

  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    fromDate = getFromDate(now);
    toDate = getToDate(now);
  }

  DateTime getFromDate(DateTime input) {
    return DateTime(input.year, input.month, input.day, 0, 0, 0);
  }

  DateTime getToDate(DateTime input) {
    return DateTime(input.year, input.month, input.day, 23, 59, 59);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KayleeText.normal16W500('Từ'),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.px8),
          child: KayleeDateText(
            initDate: fromDate,
            onTap: () async {
              await showPickerPopup(
                  context: context,
                  builder: (context) {
                    return KayleeDatePicker(
                      maximumDate: toDate,
                      initialDateTime: fromDate,
                      onDateTimeChanged: (changed) {
                        setState(() {
                          fromDate = getFromDate(changed);
                        });
                        widget.onSelect?.call(fromDate, toDate);
                      },
                      backgroundColor: Colors.white,
                    );
                  });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.px16),
          child: KayleeText.normal16W500('Đến'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.px8),
          child: KayleeDateText(
            initDate: toDate,
            onTap: () async {
              await showPickerPopup(
                  context: context,
                  builder: (context) {
                    return KayleeDatePicker(
                      maximumDate: getToDate(now),
                      minimumDate: fromDate,
                      initialDateTime: toDate,
                      onDateTimeChanged: (changed) {
                        setState(() {
                          toDate = getToDate(changed);
                        });
                        widget.onSelect?.call(fromDate, toDate);
                      },
                      backgroundColor: Colors.white,
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
