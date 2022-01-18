import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';

class ProductSupplierImage extends StatelessWidget {
  final ProductImage image;

  const ProductSupplierImage(this.image, {
    Key? key,
  }) : super(key: key);

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
          errorWidget: (context, url, error) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
