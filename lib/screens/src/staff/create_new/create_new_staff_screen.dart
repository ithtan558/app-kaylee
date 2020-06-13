import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/branch/widgets/branch_select.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CreateNewStaffScreen extends StatefulWidget {
  factory CreateNewStaffScreen.newInstance() = CreateNewStaffScreen._;

  CreateNewStaffScreen._();

  @override
  _CreateNewStaffScreenState createState() => _CreateNewStaffScreenState();
}

class _CreateNewStaffScreenState extends BaseState<CreateNewStaffScreen> {
  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: Strings.taoNhanVienMoi,
          actionTitle: Strings.tao,
          onActionClick: () {},
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: Column(
          children: [
            KayleeImagePicker(
              onImageSelect: (file, {existedImage}) {},
            ),
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
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeTextField.picker(
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
                    return BranchSelect(controller: controller);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
