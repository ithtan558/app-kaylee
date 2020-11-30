import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

class ProductSupplierVideo extends StatefulWidget {
  final ProductImage image;

  ProductSupplierVideo(this.image);

  @override
  _ProductSupplierVideoState createState() => _ProductSupplierVideoState();
}

class _ProductSupplierVideoState extends State<ProductSupplierVideo> {
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      borderRadius: BorderRadius.circular(Dimens.px10),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: widget.image.value ?? '',
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => SizedBox(),
        ),
      ),
    );
  }
}
