import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleePriceText extends StatelessWidget {
  final dynamic price;
  final TextStyle? textStyle;
  final bool showUnit;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;

  factory KayleePriceText.normal(
    dynamic price, {
    TextStyle? textStyle,
    TextAlign textAlign = TextAlign.start,
    TextOverflow? textOverflow,
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

  factory KayleePriceText.hyper16W400(dynamic price) => KayleePriceText.normal(
        price,
        textStyle: TextStyles.hyper16W400,
      );

  factory KayleePriceText.hint12W400(dynamic price,
          {TextDecoration? decoration}) =>
      KayleePriceText.normal(
        price,
        textStyle: TextStyles.hint12W400.copyWith(decoration: decoration),
      );

  factory KayleePriceText.noUnit(dynamic price, {TextStyle? textStyle}) =>
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

  const KayleePriceText(this.price,
      {Key? key,
      this.textStyle,
      this.showUnit = true,
      this.textAlign = TextAlign.start,
      this.textOverflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KayleeText(
      CurrencyUtils.formatVNDWithCustomUnit(price ?? 0,
          unit: showUnit ? 'đ' : ''),
      style: textStyle ?? TextStyles.hyper16W500,
      maxLines: 1,
      textAlign: textAlign,
      overflow: textOverflow,
    );
  }
}

class KayleeTitlePriceText extends StatelessWidget {
  final String? title;
  final dynamic price;
  final bool isBold;

  const KayleeTitlePriceText(
      {Key? key, this.title, this.price, this.isBold = false})
      : super(key: key);

  factory KayleeTitlePriceText.normal({String? title, dynamic price}) =>
      KayleeTitlePriceText(
        title: title,
        price: price,
      );

  factory KayleeTitlePriceText.bold({String? title, dynamic price}) =>
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

class KayleePriceUnitText extends StatelessWidget {
  final dynamic price;
  final TextStyle? textStyle;
  final MainAxisAlignment? alignment;

  const KayleePriceUnitText(this.price,
      {Key? key, this.textStyle, this.alignment})
      : super(key: key);

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
