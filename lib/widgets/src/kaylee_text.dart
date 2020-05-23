import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/text_utils.dart';

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
