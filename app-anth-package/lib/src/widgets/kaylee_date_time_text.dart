import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeDateTimeText extends StatelessWidget {
  final DateTime? time;
  final String format;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const KayleeDateTimeText(this.time,
      {Key? key, this.format = '', this.textAlign, this.textStyle})
      : super(key: key);

  factory KayleeDateTimeText.normal(DateTime time,
          {TextAlign? textAlign, TextStyle? textStyle}) =>
      KayleeDateTimeText(
        time,
        textAlign: textAlign,
        textStyle: textStyle,
        format:
            '${DateFormat.HOUR24 * 2}:${DateFormat.MINUTE * 2} ${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}',
      );

  factory KayleeDateTimeText.normalFromServer(int time,
          {TextAlign? textAlign, TextStyle? textStyle}) =>
      KayleeDateTimeText.normal(
        time.toDateTimeFromServer,
        textAlign: textAlign,
        textStyle: textStyle,
      );

  factory KayleeDateTimeText.dayMonth(DateTime time,
          {TextAlign? textAlign, TextStyle? textStyle}) =>
      KayleeDateTimeText(
        time,
        textAlign: textAlign,
        textStyle: textStyle,
        format: '${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}',
      );

  factory KayleeDateTimeText.dayMonthFromServer(int time,
          {TextAlign? textAlign, TextStyle? textStyle}) =>
      KayleeDateTimeText(
        time.toDateTimeFromServer,
        textAlign: textAlign,
        textStyle: textStyle,
        format: '${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}',
      );

  factory KayleeDateTimeText.dayMonthYear(DateTime? time,
          {TextAlign? textAlign, TextStyle? textStyle}) =>
      KayleeDateTimeText(
        time,
        textAlign: textAlign,
        textStyle: textStyle,
        format:
            '${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}',
      );

  factory KayleeDateTimeText.dayMonthYearFromServer(int time,
          {TextAlign? textAlign, TextStyle? textStyle}) =>
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

class KayleeDateText extends StatelessWidget {
  final DateTime initDate;
  final VoidCallback? onTap;

  const KayleeDateText({Key? key, required this.initDate, this.onTap})
      : super(key: key);

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
              IconAssets.icCalendar,
              width: Dimens.px16,
              height: Dimens.px16,
              package: anthPackage,
            ),
          )
        ],
      ),
    );
  }
}

class KayleeDateRangeText extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback? onTap;
  final double? textSize;

  const KayleeDateRangeText(
      {Key? key,
      this.fromDate,
      this.onTap,
      this.toDate,
      this.textSize = Dimens.px16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                KayleeDateTimeText.dayMonthYear(
                  fromDate,
                  textStyle:
                      TextStyles.hyper16W400.copyWith(fontSize: textSize),
                ),
                KayleeText(
                  ' - ',
                  style: TextStyles.hyper16W400.copyWith(fontSize: textSize),
                ),
                KayleeDateTimeText.dayMonthYear(
                  toDate,
                  textStyle:
                      TextStyles.hyper16W400.copyWith(fontSize: textSize),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.px4),
            child: Image.asset(
              IconAssets.icCalendar,
              package: anthPackage,
              width: Dimens.px16,
              height: Dimens.px16,
            ),
          )
        ],
      ),
    );
  }
}

class KayleeDatePickerTextController {
  DateTimeRange? value;

  KayleeDatePickerTextController({this.value});
}
