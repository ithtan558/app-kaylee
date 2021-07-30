import 'package:flutter/material.dart';

class KayleeImageInfoLayout extends StatelessWidget {
  final Widget? imageView;
  final Widget? infoView;

  const KayleeImageInfoLayout({Key? key, this.imageView, this.infoView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: imageView ?? const SizedBox.shrink(),
        ),
        Expanded(
          child: infoView ?? const SizedBox.shrink(),
        )
      ],
    );
  }
}
