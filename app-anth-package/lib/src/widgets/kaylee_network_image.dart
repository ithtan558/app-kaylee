import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final int? memCacheHeight;
  final int? memCacheWidth;
  final double? width;
  final double? height;

  const KayleeNetworkImage.normal(
    this.url, {
    Key? key,
    this.fit = BoxFit.cover,
    this.memCacheHeight,
    this.memCacheWidth,
    this.width,
    this.height,
  }) : super(key: key);

  const KayleeNetworkImage.square(
    this.url, {
    Key? key,
    this.fit = BoxFit.cover,
    int? memCacheSize,
    double? size,
  })  : memCacheWidth = memCacheSize,
        memCacheHeight = memCacheSize,
        width = size,
        height = size,
        super(key: key);

  Widget get _placeHolder => Center(
        child: Image.asset(
          IconAssets.icImageHolder,
          fit: BoxFit.cover,
          width: Dimens.px40,
          height: Dimens.px40,
          package: anthPackage,
        ),
      );

  ///chưa có design cụ thể, để tạm giống [_placeHolder]
  Widget get _errorWidget => _placeHolder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      memCacheHeight: memCacheHeight,
      memCacheWidth: memCacheWidth,
      errorWidget: (context, url, error) => _errorWidget,
      placeholder: (context, url) => _placeHolder,
      width: width,
      height: height,
    );
  }
}
