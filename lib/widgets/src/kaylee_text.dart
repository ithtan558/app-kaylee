import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/text_utils.dart';

class KayleeDateTimeText extends StatelessWidget {
  final int time;
  final String format;
  final TextAlign textAlign;
  final TextStyle textStyle;

  KayleeDateTimeText(this.time, {this.format, this.textAlign, this.textStyle});

  factory KayleeDateTimeText.normal(int time, {TextAlign textAlign}) =>
      KayleeDateTimeText(
        time,
        textAlign: textAlign,
        format:
            '${DateFormat.HOUR24 * 2}:${DateFormat.MINUTE * 2} ${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}',
      );

  factory KayleeDateTimeText.dayMonth(int time,
          {TextAlign textAlign, TextStyle textStyle}) =>
      KayleeDateTimeText(
        time,
        textAlign: textAlign,
        textStyle: textStyle,
        format: '${DateFormat.DAY * 2}/${DateFormat.NUM_MONTH * 2}',
      );

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat(format)
        .format(DateTime.fromMillisecondsSinceEpoch((time ?? 0) * 1000));
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

  factory KayleePriceText.normal(dynamic price, {TextStyle textStyle}) =>
      KayleePriceText(
        price,
        textStyle: textStyle,
        showUnit: true,
      );

  factory KayleePriceText.noUnit(dynamic price, {TextStyle textStyle}) =>
      KayleePriceText(
        price,
        textStyle: textStyle,
        showUnit: false,
      );

  KayleePriceText(this.price, {this.textStyle, this.showUnit = true});

  @override
  Widget build(BuildContext context) {
    return KayleeText(
      TextUtils.formatVND(price ?? 0, unit: showUnit ? 'đ' : null),
      style: textStyle ?? TextStyles.hyper16W500,
    );
  }
}

class KayleePriceUnitText extends StatelessWidget {
  final dynamic price;
  final TextStyle textStyle;

  KayleePriceUnitText(this.price, {this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KayleePriceText.noUnit(
          price,
          textStyle: textStyle ?? TextStyles.normal16W400,
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.px8),
          child: KayleeText('đ', style: TextStyles.hint16W400),
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
      style: ScreenUtils.textTheme(context).bodyText2.merge(style),
    );
  }
}
