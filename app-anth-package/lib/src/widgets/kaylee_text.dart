import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  factory KayleeText.hint16W400(String text,
          {TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hint16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.hint16W500(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hint16W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal16W500(String text,
          {TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal16W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal26W700(String text,
          {TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal26W700,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal18W700(String text,
          {TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal18W700,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal12W400(String text,
          {TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal12W500(String text,
          {TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal12W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normalWhite18W700(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normalWhite18W700,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normalWhite16W500(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normalWhite16W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normalWhite16W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normalWhite16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normalWhite12W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normalWhite12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.normal16W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.normal16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.hyper16W500(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hyper16W500,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.hyper16W700(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hyper16W700,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.hyper16W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hyper16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.error12W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.error12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.error16W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.error16W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.textFieldBorder12W400(String text,
          {TextAlign textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.textFieldBorder12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  const KayleeText(this.text,
      {Key? key,
      this.textAlign = TextAlign.start,
      this.maxLines,
      this.style,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  factory KayleeText.hint12W400(String text,
          {TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hint12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  factory KayleeText.hyper12W400(String text,
          {TextAlign? textAlign = TextAlign.start,
          int? maxLines,
          TextOverflow? overflow}) =>
      KayleeText(
        text,
        textAlign: textAlign,
        style: TextStyles.hyper12W400,
        maxLines: maxLines,
        overflow: overflow,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: context.textTheme.bodyText2?.merge(style),
    );
  }
}
