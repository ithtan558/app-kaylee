import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/brand_select_textfield/brand_select_list.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewStaffScreenData {
  final NewStaffScreenOpenFrom openFrom;
  Employee employee;

  NewStaffScreenData({this.openFrom, this.employee});
}

enum NewStaffScreenOpenFrom { staffItem, addNewStaffBtn }

class CreateNewStaffScreen extends StatefulWidget {
  static Widget newInstance() => CreateNewStaffScreen._();

  CreateNewStaffScreen._();

  @override
  _CreateNewStaffScreenState createState() => _CreateNewStaffScreenState();
}

class _CreateNewStaffScreenState extends BaseState<CreateNewStaffScreen> {
  NewStaffScreenOpenFrom openFrom;

  @override
  void initState() {
    super.initState();
    final data = context.bundle.args as NewStaffScreenData;
    openFrom = data?.openFrom;
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == NewStaffScreenOpenFrom.staffItem
              ? Strings.chinhSuaNhanVien
              : Strings.taoNhanVienMoi,
          actionTitle: openFrom == NewStaffScreenOpenFrom.staffItem
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {},
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: Column(
          children: [
            KayleeImagePicker(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
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
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleePickerTextField(
                title: Strings.ngaySinh,
                hint: Strings.chonNgayThangNam,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleePickerTextField(
                title: Strings.queQuan,
                hint: Strings.chonTinhTpHint,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeFullAddressInput(
                title: Strings.diaChiHienTai,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeTextField.phoneInput(
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeTextField.normal(
                title: Strings.emailTuyChon,
                hint: Strings.emailTuyChonHint,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeTextField.normal(
                title: Strings.chucVu,
                hint: Strings.chucVuTaiNoiLamViec,
              ),
            ),
            KayleeTextField.selection(
              title: Strings.diaDiemPhucVu,
              content: '(0) địa điểm được chọn',
              buttonText: Strings.chinhSua,
              onPress: () {
                showKayleeBottomSheet(
                  context,
                  initialChildSize: 356 / 667,
                  minChildSize: 356 / 667,
                  builder: (c, controller) {
                    return BrandSelectList(scrollController: controller);
                  },
                );
              },
            ),
            if (openFrom == NewStaffScreenOpenFrom.staffItem)
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px32, bottom: Dimens.px16),
                child: HyperLinkText(
                  text: Strings.xoaNhanVien,
                  onTap: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
