import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class HyperLinkText extends StatelessWidget {
  final String text;
  final void Function() onTap;

  HyperLinkText({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: KayleeText(text ?? '', style: TextStyles.hyper16W400),
      ),
    );
  }
}
