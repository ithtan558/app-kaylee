import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_list_screen_bloc.dart';

class SupplierInfo extends StatelessWidget {
  const SupplierInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierProdListScreenBloc, SingleModel<Supplier>>(
      builder: (context, state) {
        if (state.item.isNull) {
          return const SizedBox.shrink();
        }
        final supplier = state.item!;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(Dimens.px5),
              child: KayleeNetworkImage.square(
                supplier.image,
                size: Dimens.px80,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: Dimens.px16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.px8),
                    child: KayleeText.normal16W500(
                      supplier.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Images.icLocationPin,
                        width: Dimens.px16,
                        height: Dimens.px16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: Dimens.px8),
                        child: KayleeText.hint16W400(
                          supplier.city?.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimens.px18),
                    child: KayleeText.hyper16W400(
                      Strings.hienCoSanPham
                          .replaceFirst('{}', '${supplier.numberOfProduct}'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ))
          ],
        );
      },
    );
  }
}
