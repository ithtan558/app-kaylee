import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/kaylee_date_picker.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeDateTimeText extends StatelessWidget {
  final DateTime time;
  final String format;
  final TextAlign textAlign;
  final TextStyle textStyle;

  KayleeDateTimeText(this.time, {this.format, this.textAlign, this.textStyle});

  factory KayleeDateTimeText.normal(DateTime time,
          {TextAlign textAlign, TextStyle textStyle}) =>
      KayleeDateTimeText(
        time,
        textAlign: textAlign,
        textStyle: textStyle,
        format:
            '${DateFormat.HOUR24 * 2}:${DateFormat.MINUTE * 2} ${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}',
      );

  factory KayleeDateTimeText.normalFromServer(int time,
          {TextAlign textAlign, TextStyle textStyle}) =>
      KayleeDateTimeText.normal(
        time.toDateTimeFromServer,
        textAlign: textAlign,
        textStyle: textStyle,
      );

  factory KayleeDateTimeText.dayMonth(DateTime time,
          {TextAlign textAlign, TextStyle textStyle}) =>
      KayleeDateTimeText(
        time,
        textAlign: textAlign,
        textStyle: textStyle,
        format: '${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}',
      );

  factory KayleeDateTimeText.dayMonthFromServer(int time,
          {TextAlign textAlign, TextStyle textStyle}) =>
      KayleeDateTimeText(
        time.toDateTimeFromServer,
        textAlign: textAlign,
        textStyle: textStyle,
        format: '${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}',
      );

  factory KayleeDateTimeText.dayMonthYear(DateTime time,
          {TextAlign textAlign, TextStyle textStyle}) =>
      KayleeDateTimeText(
        time,
        textAlign: textAlign,
        textStyle: textStyle,
        format:
            '${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}',
      );

  factory KayleeDateTimeText.dayMonthYearFromServer(int time,
          {TextAlign textAlign, TextStyle textStyle}) =>
      KayleeDateTimeText.dayMonthYear(
        time.toDateTimeFromServer,
        textAlign: textAlign,
        textStyle: textStyle,
      );

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat(format).format(time ?? DateTime.now());
    return KayleeText(
      dateString,
      maxLines: 1,
      textAlign: textAlign,
      style: textStyle ?? TextStyles.normal16W400,
    );
  }
}

class KayleeTitlePriceText extends StatelessWidget {
  final String title;
  final dynamic price;
  final bool isBold;

  KayleeTitlePriceText({this.title, this.price, this.isBold = false});

  factory KayleeTitlePriceText.normal({String title, dynamic price}) =>
      KayleeTitlePriceText(
        title: title,
        price: price,
      );

  factory KayleeTitlePriceText.bold({String title, dynamic price}) =>
      KayleeTitlePriceText(
        title: title,
        price: price,
        isBold: true,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: Dimens.px8),
            child: KayleeText(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: isBold ? TextStyles.normal18W700 : null,
            ),
          ),
        ),
        KayleePriceUnitText(
          price,
          textStyle: isBold ? TextStyles.hyper18W700 : TextStyles.hyper16W500,
        )
      ],
    );
  }
}

class KayleePriceText extends StatelessWidget {
  final dynamic price;
  final TextStyle textStyle;
  final bool showUnit;
  final TextAlign textAlign;
  final TextOverflow textOverflow;

  factory KayleePriceText.normal(
    dynamic price, {
    TextStyle textStyle,
    TextAlign textAlign = TextAlign.start,
    TextOverflow textOverflow,
  }) =>
      KayleePriceText(
        price,
        textStyle: textStyle,
        showUnit: true,
        textAlign: textAlign,
        textOverflow: textOverflow,
      );

  factory KayleePriceText.hyper16W700(dynamic price) => KayleePriceText.normal(
        price,
        textStyle: TextStyles.hyper16W700,
      );

  factory KayleePriceText.noUnit(dynamic price, {TextStyle textStyle}) =>
      KayleePriceText(
        price,
        textStyle: textStyle,
        showUnit: false,
      );

  factory KayleePriceText.noUnitNormal26W700(dynamic price) =>
      KayleePriceText.noUnit(
        price,
        textStyle: TextStyles.normal26W700,
      );

  factory KayleePriceText.noUnitNormal18W700(dynamic price) =>
      KayleePriceText.noUnit(
        price,
        textStyle: TextStyles.normal18W700,
      );

  factory KayleePriceText.noUnitNormal16W400(dynamic price) =>
      KayleePriceText.noUnit(
        price,
        textStyle: TextStyles.normal16W400,
      );

  KayleePriceText(this.price,
      {this.textStyle,
        this.showUnit = true,
        this.textAlign = TextAlign.start,
        this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return KayleeText(
      CurrencyUtils.formatVNDWithCustomUnit(price ?? 0,
          unit: showUnit ? 'đ' : null),
      style: textStyle ?? TextStyles.hyper16W500,
      maxLines: 1,
      textAlign: textAlign,
      overflow: textOverflow,
    );
  }
}

class KayleePriceUnitText extends StatelessWidget {
  final dynamic price;
  final TextStyle textStyle;
  final MainAxisAlignment alignment;

  KayleePriceUnitText(this.price, {this.textStyle, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.center,
      children: [
        KayleePriceText.noUnit(
          price,
          textStyle: textStyle ?? TextStyles.normal16W400,
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.px8),
          child: KayleeText.hint16W400('đ'),
        )
      ],
    );
  }
}

class KayleeText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle style;
  final int maxLines;
  final TextOverflow overflow;

  factory KayleeText.hint16W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int maxLines,
          TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hint16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.hint16W500(String text,
          {TextAlign textAlign = TextAlign.start,
          int maxLines,
          TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hint16W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal16W500(String text,
          {TextAlign textAlign = TextAlign.start,
          int maxLines,
          TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal16W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal26W700(String text,
          {TextAlign textAlign = TextAlign.start,
          int maxLines,
          TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal26W700,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal18W700(String text,
      {TextAlign textAlign = TextAlign.start,
        int maxLines,
        TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal18W700,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal12W400(String text,
      {TextAlign textAlign = TextAlign.start,
        int maxLines,
        TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normalWhite18W700(String text,
      {TextAlign textAlign = TextAlign.start,
        int maxLines,
        TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normalWhite18W700,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normalWhite16W500(String text,
      {TextAlign textAlign = TextAlign.start,
        int maxLines,
        TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normalWhite16W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normalWhite16W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int maxLines,
          TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normalWhite16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normalWhite12W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int maxLines,
          TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normalWhite12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal16W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int maxLines,
          TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.hyper16W500(String text,
          {TextAlign textAlign = TextAlign.start,
          int maxLines,
          TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hyper16W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.hyper16W400(String text,
      {TextAlign textAlign = TextAlign.start,
        int maxLines,
        TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hyper16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.error12W400(String text,
      {TextAlign textAlign = TextAlign.start,
        int maxLines,
        TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.error12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.error16W400(String text,
      {TextAlign textAlign = TextAlign.start,
        int maxLines,
        TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.error16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.textFieldBorder12W400(String text,
      {TextAlign textAlign = TextAlign.start,
        int maxLines,
        TextOverflow overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.textFieldBorder12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  KayleeText(this.text,
      {this.textAlign = TextAlign.start,
        this.maxLines,
        this.style,
        this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: context.textTheme.bodyText2.merge(style),
    );
  }
}

class KayleeDateText extends StatelessWidget {
  final DateTime initDate;
  final void Function() onTap;

  KayleeDateText({@required this.initDate, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: KayleeDateTimeText.dayMonthYear(
              initDate,
              textStyle: TextStyles.hyper16W400
                  .copyWith(decoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.px4),
            child: Image.asset(
              Images.ic_calendar,
              width: Dimens.px16,
              height: Dimens.px16,
            ),
          )
        ],
      ),
    );
  }
}

class KayleeDatePickerText extends StatefulWidget {
  final ValueChanged<DateTime> onSelect;
  final KayleeDatePickerTextController controller;

  KayleeDatePickerText({this.onSelect, this.controller});

  @override
  _KayleeDatePickerTextState createState() => _KayleeDatePickerTextState();
}

class _KayleeDatePickerTextState extends BaseState<KayleeDatePickerText> {
  DateTime selectedDate;
  DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.controller?.value ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeDateText(
      initDate: date,
      onTap: () {
        showPickerPopup(
            context: context,
            onDone: () {
              if (selectedDate.isNotNull) {
                date = selectedDate;
                selectedDate = null;
                widget.controller?.value = date;

                setState(() {});
                widget.onSelect?.call(date);
              }
            },
            onDismiss: () {
              selectedDate = null;
            },
            builder: (context) {
              return CupertinoDatePicker(
                maximumDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                initialDateTime: date,
                onDateTimeChanged: (changed) {
                  print('[TUNG] ===> onDateTimeChanged');
                  selectedDate = changed;
                },
              );
            });
      },
    );
  }
}

class KayleeDatePickerTextController {
  DateTime value;
}

class KayleeDateRangePickerText extends StatefulWidget {
  final void Function(DateTime from, DateTime to) onSelect;

  KayleeDateRangePickerText({this.onSelect});

  @override
  _KayleeDateRangePickerTextState createState() =>
      _KayleeDateRangePickerTextState();
}

class _KayleeDateRangePickerTextState
    extends BaseState<KayleeDateRangePickerText> {
  final now = DateTime.now();

  DateTime fromDate;
  DateTime toDate;

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

                        if (widget.onSelect.isNotNull) {
                          widget.onSelect(fromDate, toDate);
                        }
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
                        if (widget.onSelect.isNotNull) {
                          widget.onSelect(fromDate, toDate);
                        }
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

class KayleeTotalAmountText extends StatelessWidget {
  final dynamic price;

  KayleeTotalAmountText({this.price});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        children: [
          KayleeText.hint16W400(Strings.tong),
          Container(
            height: Dimens.px48,
            margin: EdgeInsets.symmetric(horizontal: Dimens.px8),
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.px8, horizontal: Dimens.px18),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimens.px5),
                border: Border.fromBorderSide(
                    BorderSide(color: ColorsRes.hyper, width: Dimens.px2))),
            child: KayleePriceText.noUnitNormal26W700(price),
          ),
          KayleeText.hint16W400(Strings.vnd)
        ],
      ),
    );
  }
}
