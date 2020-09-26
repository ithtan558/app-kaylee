import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart' hide OrderItem;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/order_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewOrderScreenData {
  final OrderScreenOpenFrom openFrom;

  NewOrderScreenData({this.openFrom});
}

enum OrderScreenOpenFrom { detailButton, addNewButton }

class CreateNewOrderScreen extends StatefulWidget {
  static Widget newInstance() => CreateNewOrderScreen._();

  CreateNewOrderScreen._();

  @override
  _CreateNewOrderScreenState createState() => _CreateNewOrderScreenState();
}

class _CreateNewOrderScreenState extends BaseState<CreateNewOrderScreen> {
  final services = [for (int i = 0; i <= 2; i++) i];
  OrderScreenOpenFrom openFrom;
  final brandController = PickInputController<Brand>();
  final employeeController = PickInputController<Employee>();

  @override
  void initState() {
    super.initState();
    final data = context.bundle.args as NewOrderScreenData;
    openFrom = data?.openFrom;
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == OrderScreenOpenFrom.detailButton
              ? Strings.chinhSuaDonHang
              : Strings.taoDonHangMoi,
          actionTitle: openFrom == OrderScreenOpenFrom.detailButton
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {},
        ),
        body: ListView.builder(
          itemBuilder: (c, index) {
            if (index == 0)
              return Padding(
                padding: const EdgeInsets.all(Dimens.px16),
                child: KayleeTextField.selection(
                  title: Strings.thongTinKh,
                  buttonText: Strings.chinhSua,
                  onPress: () {},
                ),
              );
            if (index == 1)
              return Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: KayleePickerTextField(
                  title: Strings.chiNhanh,
                  hint: Strings.chonChiNhanhTrongDs,
                  controller: brandController,
                ),
              );
            if (index == 2)
              return Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: KayleePickerTextField(
                  title: Strings.nhanVienThucThien,
                  hint: Strings.chonNhanVienTrongDs,
                  controller: employeeController,
                ),
              );
            if (index == 3)
              return LabelDividerView.withButton(
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
                                await showOrderItemList();
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
                                await showOrderItemList();
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
              );

            final orderItemIndex = index - 4;
            if (orderItemIndex >= 0 &&
                orderItemIndex <=
                    (services.isNullOrEmpty ? 0 : (services.length))) {
              if (services.isNullOrEmpty)
                return Padding(
                  padding: const EdgeInsets.all(Dimens.px16),
                  child: KayleeText.hint16W400(
                    Strings.chuSuDungDichVu,
                  ),
                );
              else if (orderItemIndex < services.length)
                return OrderItem(
                  data: services.elementAt(orderItemIndex),
                  onDismissed: (value) {
                    setState(() {
                      services.removeWhere((e) => e == value);
                    });
                  },
                );
              else {
                return Container(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      top: Dimens.px16,
                      bottom: Dimens.px20),
                  child: Column(
                    children: [
                      KayleeTitlePriceText.normal(
                        title: Strings.tongChiPhi,
                        price: 190000,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Dimens.px8),
                        child: KayleeTitlePriceText.bold(
                          title: Strings.thanhTien,
                          price: 190000,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }

            if (index ==
                4 + (services.isNullOrEmpty ? 0 : services.length) + 1) {
              return LabelDividerView(title: Strings.giamGia);
            }

            if (index ==
                4 + (services.isNullOrEmpty ? 0 : services.length) + 2) {
              return Padding(
                padding: const EdgeInsets.all(Dimens.px16),
                child: KayleeTextField.unitSelection(
                  hint: '0',
                ),
              );
            }

            return KayLeeRoundedButton.normal(
              text: Strings.thanhToan,
              margin: const EdgeInsets.all(Dimens.px8),
              onPressed: () {},
            );
          },
          itemCount: 4 //từ view 'thông tin khách hàng' -> 'Danh sách dịch vụ'
              +
              (services.isNullOrEmpty
                  ? 1
                  : (services.length + 1)) // list của service item
              +
              3, // từ view 'Giảm giá' -> button 'Thanh toán'
        ),
      ),
    );
  }

  Future showOrderItemList() {
    return showKayleeDialog(
        context: context,
        borderRadius: BorderRadius.circular(Dimens.px5),
        margin: const EdgeInsets.all(Dimens.px8),
        showFullScreen: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
              child: KayleeText.normal18W700(Strings.danhSachDichVu),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (c, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimens.px16),
                      child: KayleeText.normal16W500(
                        "Chưa có danh mục (1)",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    KayleeGridView(
                      padding: EdgeInsets.all(Dimens.px8),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 103 / 195,
                      itemBuilder: (c, index) {
                        return KayleeProdItemView.canSelect(
                          data: KayleeProdItemData(
                              name: 'Tóc kiểu thôn nữ',
                              image:
                                  'https://img.jakpost.net/c/2019/12/09/2019_12_09_83333_1575827116._large.jpg',
                              price: 600000),
                          onSelect: (selected) {},
                        );
                      },
                      itemCount: 4,
                    )
                  ],
                );
              },
              itemCount: 3,
            )),
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
                      },
                    ),
                  ),
                  Expanded(
                    child: KayLeeRoundedButton.normal(
                      text: Strings.xacNhan,
                      margin: const EdgeInsets.only(left: Dimens.px8),
                      onPressed: () {
                        popScreen();
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
