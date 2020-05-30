import 'package:flutter/material.dart';

class ImageInfoLayout extends StatelessWidget {
  final Widget imageView;
  final Widget infoView;

  ImageInfoLayout({this.imageView, this.infoView});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: imageView ?? Container(),
        ),
        Expanded(
          child: infoView ?? Container(),
        )
      ],
    );
  }
}
