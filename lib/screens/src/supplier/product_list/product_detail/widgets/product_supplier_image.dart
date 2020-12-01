import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

class ProductSupplierImage extends StatelessWidget {
  final ProductImage image;

  ProductSupplierImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      borderRadius: BorderRadius.circular(Dimens.px10),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: image.value ?? '',
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => SizedBox(),
        ),
      ),
    );
  }
}
