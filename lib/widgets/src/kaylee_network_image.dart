import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final int memCacheHeight;
  final int memCacheWidth;

  const KayleeNetworkImage.normal(
    this.url, {
    this.fit = BoxFit.cover,
    this.memCacheHeight,
    this.memCacheWidth,
  });

  Widget get _placeHolder => Center(
        child: Image.asset(
          Images.ic_image_holder,
          fit: BoxFit.cover,
          width: Dimens.px40,
          height: Dimens.px40,
        ),
      );

  ///chưa có design cụ thể, để tạm giống [_placeHolder]
  Widget get _errorWidget => _placeHolder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      fit: fit,
      memCacheHeight: memCacheHeight,
      memCacheWidth: memCacheWidth,
      errorWidget: (context, url, error) => _errorWidget,
      placeholder: (context, url) => _placeHolder,
    );
  }
}
