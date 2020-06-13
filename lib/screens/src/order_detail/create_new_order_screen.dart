import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/service_item.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CreateNewOrderScreen extends StatefulWidget {
  factory CreateNewOrderScreen.newInstance() = CreateNewOrderScreen._;

  CreateNewOrderScreen._();

  @override
  _CreateNewOrderScreenState createState() => _CreateNewOrderScreenState();
}

class _CreateNewOrderScreenState extends BaseState<CreateNewOrderScreen> {
  final services = [for (int i = 0; i <= 5; i++) i];

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar.hyperTextAction(
          title: Strings.chinhSuaDonHang,
          actionTitle: Strings.luu,
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
                child: KayleeTextField.picker(
                  title: Strings.chiNhanh,
                  hint: Strings.chonChiNhanhTrongDs,
                ),
              );

            if (index == 2)
              return LabelDividerView.withButton(
                title: Strings.danhSachDichVu,
                buttonText: Strings.themDichVu,
                onPress: () {},
              );
            if (index - 3 >= 0 &&
                index - 3 <= (services.isNullOrEmpty ? 0 : (services.length))) {
              if (services.isNullOrEmpty)
                return Padding(
                  padding: const EdgeInsets.all(Dimens.px16),
                  child: KayleeText.hint16W400(
                    Strings.chuSuDungDichVu,
                  ),
                );
              else if (index - 3 < services.length)
                return ServiceItem(
                  index: services.elementAt(index - 3),
                  onDismissed: (item) {
                    setState(() {
                      services.removeWhere((e) => e == item);
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
                3 + (services.isNullOrEmpty ? 0 : services.length) + 1) {
              return LabelDividerView(title: Strings.giamGia);
            }

            if (index ==
                3 + (services.isNullOrEmpty ? 0 : services.length) + 2) {
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
          itemCount: 3 //từ view 'thông tin khách hàng' -> 'Danh sách dịch vụ'
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
}
