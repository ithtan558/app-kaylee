import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

enum CustomerScreenOpenFrom { customerListItem, cashier, addNewCustomerBtn }

class NewCustomerScreenData {
  CustomerScreenOpenFrom openFrom;

  NewCustomerScreenData({this.openFrom});
}

class CreateNewCustomerScreen extends StatefulWidget {
  static Widget newInstance() => CreateNewCustomerScreen._();

  CreateNewCustomerScreen._();

  @override
  _CreateNewCustomerScreenState createState() =>
      _CreateNewCustomerScreenState();
}

class _CreateNewCustomerScreenState extends BaseState<CreateNewCustomerScreen> {
  CustomerScreenOpenFrom openFrom;

  @override
  void initState() {
    super.initState();
    final data = bundle.args as NewCustomerScreenData;
    openFrom = data?.openFrom;
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == CustomerScreenOpenFrom.customerListItem
              ? Strings.chinhSuaThongTinKhachHang
              : Strings.taoKhachHangMoi,
          actionTitle: openFrom == CustomerScreenOpenFrom.customerListItem
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {},
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
              child: KayleeImagePicker(
                onImageSelect: (file, {existedImage}) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayleeTextField.normal(
                      title: Strings.ho,
                      hint: Strings.hoHint,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleeTextField.normal(
                      title: Strings.ten,
                      hint: Strings.tenHint,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayleeTextField.picker(
                      title: Strings.namSinh,
                      hint: Strings.chonNam,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleeTextField.picker(
                      title: Strings.canCuocCmnd,
                      hint: Strings.canCuocCmndHint,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: KayleeTextField.picker(
                title: Strings.queQuan,
                hint: Strings.chonTinhTpHint,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: KayleeFullAddressInput(
                title: Strings.diaChiHienTai,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: KayleeTextField.phoneInput(
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: KayleeTextField.normal(
                title: Strings.emailTuyChon,
                hint: Strings.emailTuyChonHint,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
            if (openFrom == CustomerScreenOpenFrom.cashier)
              KayLeeRoundedButton.normal(
                text: Strings.taoDonHang,
                onPressed: () {},
                margin: const EdgeInsets.all(Dimens.px8),
              ),
            if (openFrom == CustomerScreenOpenFrom.customerListItem)
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16, bottom: Dimens.px32),
                child: HyperLinkText(text: Strings.xoaKhachHang, onTap: () {}),
              )
          ],
        ),
      ),
    );
  }
}
