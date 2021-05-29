import 'package:flutter/material.dart';

class KayleeImageInfoLayout extends StatelessWidget {
  final Widget? imageView;
  final Widget? infoView;

  KayleeImageInfoLayout({this.imageView, this.infoView});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: imageView ?? SizedBox.shrink(),
        ),
        Expanded(
          child: infoView ?? SizedBox.shrink(),
        )
      ],
    );
  }
}
