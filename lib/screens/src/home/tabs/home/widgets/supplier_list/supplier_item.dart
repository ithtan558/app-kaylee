import 'package:anth_package/anth_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/widgets.dart';

class SupplierItem extends StatelessWidget {
  final Supplier supplier;

  SupplierItem({@required this.supplier});

  final imageRatio = 96 / 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimens.px46,
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(Dimens.px5),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            context.push(PageIntent(
                screen: SupplierProdListScreen, bundle: Bundle(supplier)));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
                child: Container(
                  width: (context.screenSize.width - Dimens.px32) * 96 / 343,
                  child: AspectRatio(
                      aspectRatio: imageRatio,
                      child: CachedNetworkImage(
                        imageUrl: supplier?.image ?? '',
                        height: 64,
                      )),
                ),
              ),
              Container(
                  width: 1,
                  height: Dimens.px16,
                  decoration: BoxDecoration(color: ColorsRes.textFieldBorder)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                  child: KayleeText.normal12W400(supplier?.name ?? '',
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
