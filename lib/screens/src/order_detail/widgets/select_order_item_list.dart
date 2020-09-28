import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/order_item.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_product_item_list/select_product_list.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_service_item_list/select_service_list.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectOrderItemList extends StatefulWidget {
  SelectOrderItemList({Key key}) : super(key: key);

  @override
  _SelectOrderItemListState createState() => _SelectOrderItemListState();
}

class _SelectOrderItemListState extends KayleeState<SelectOrderItemList> {
  List items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelDividerView.withButton(
          title: Strings.danhSachDichVu,
          buttonText: Strings.themDichVu,
          onPress: () async {
            await showKayleeDialog(
              context: context,
              showShadow: true,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.px16),
                child: Column(
                  children: [
                    KayleeText.normal18W700(
                      Strings.chonLoaiDichVu,
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px8),
                      child: KayleeText.hint16W400(
                        Strings.chonMucPhuHopVoiYeuCau,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: KayLeeRoundedButton.normal(
                        text: Strings.danhSachDichVu,
                        onPressed: () async {
                          popScreen();
                          showOrderItemList(
                            title: Strings.danhSachDichVu,
                            child: SelectServiceList.newInstance(),
                            onConfirm: () {},
                            onCancel: () {},
                          );
                        },
                        margin: EdgeInsets.zero,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: KayLeeRoundedButton.normal(
                        text: Strings.danhSachSanPham,
                        onPressed: () async {
                          popScreen();
                          showOrderItemList(
                            title: Strings.danhSachSanPham,
                            child: SelectProdList.newInstance(),
                            onConfirm: () {},
                            onCancel: () {},
                          );
                        },
                        margin: EdgeInsets.zero,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: KayLeeRoundedButton.button2(
                        text: Strings.huy,
                        onPressed: () {
                          popScreen();
                        },
                        margin: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (items.isNullOrEmpty)
          Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: KayleeText.hint16W400(
              Strings.chuSuDungDichVu,
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return OrderItem(
                data: items.elementAt(index),
                onDismissed: (value) {
                  setState(() {
                    items.removeWhere((e) => e == value);
                  });
                },
              );
            },
            itemCount: items.length,
          )
      ],
    );
  }

  Future showOrderItemList({
    String title,
    Widget child,
    VoidCallback onConfirm,
    VoidCallback onCancel,
  }) {
    return showKayleeDialog(
        context: context,
        borderRadius: BorderRadius.circular(Dimens.px5),
        margin: const EdgeInsets.all(Dimens.px8),
        showFullScreen: true,
        showShadow: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px8)
                  .copyWith(top: Dimens.px16, bottom: Dimens.px8),
              child: KayleeText.normal18W700(
                title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: child ?? SizedBox()),
            Padding(
              padding: const EdgeInsets.all(Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayLeeRoundedButton.button2(
                      text: Strings.huy,
                      margin: const EdgeInsets.only(right: Dimens.px8),
                      onPressed: () {
                        popScreen();
                        onConfirm?.call();
                      },
                    ),
                  ),
                  Expanded(
                    child: KayLeeRoundedButton.normal(
                      text: Strings.xacNhan,
                      margin: const EdgeInsets.only(left: Dimens.px8),
                      onPressed: () {
                        popScreen();
                        onCancel?.call();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
