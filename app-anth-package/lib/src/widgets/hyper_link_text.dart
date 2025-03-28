import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class HyperLinkText extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  const HyperLinkText({Key? key, this.text, this.onTap, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child:
            KayleeText(text ?? '', style: textStyle ?? TextStyles.hyper16W400),
      ),
    );
  }
}
