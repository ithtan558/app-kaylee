import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle style;

  KayleeText(this.text, {this.textAlign = TextAlign.start, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: ScreenUtils.screenTheme(context).textTheme.bodyText2.merge(style),
    );
  }
}
