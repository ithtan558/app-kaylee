import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class CreateNewReservationScreen extends StatefulWidget {
  static Widget newInstance() => CreateNewReservationScreen._();

  CreateNewReservationScreen._();

  @override
  _CreateNewReservationScreenState createState() =>
      _CreateNewReservationScreenState();
}

class _CreateNewReservationScreenState
    extends BaseState<CreateNewReservationScreen> {
  final lastNameTfController = TextEditingController();
  final nameTfController = TextEditingController();
  final lastNameFocus = FocusNode();
  final nameFocus = FocusNode();

  @override
  void dispose() {
    lastNameTfController.dispose();
    nameTfController.dispose();

    lastNameFocus.dispose();
    nameFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          actionTitle: Strings.tao,
          title: Strings.taoLichHenMoi,
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleePickerTextField(
                title: Strings.chonChiNhanh,
                hint: Strings.chonChinhanhDeDatLich,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayleeTextField.normal(
                      title: Strings.ho,
                      hint: Strings.hoHint,
                      controller: lastNameTfController,
                      textInputAction: TextInputAction.next,
                      focusNode: lastNameFocus,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleeTextField.normal(
                      title: Strings.ten,
                      hint: Strings.tenHint,
                      controller: nameTfController,
                      textInputAction: TextInputAction.next,
                      focusNode: nameFocus,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px16),
                child: KayleeTextField.phoneInput()),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeFullAddressInput(
                title: Strings.diaChiHienTai,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayleePickerTextField(
                      title: Strings.ngayDat,
                      hint: Strings.chonNgay,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleePickerTextField(
                      title: Strings.gioDat,
                      hint: Strings.chonThoiGian,
                    ),
                  ),
                ],
              ),
            ),
            KayleeTextField.multiLine(
              title: Strings.ghiChu,
              fieldHeight: 233,
              hint: Strings.nhapGhiChuCuaKH,
            )
          ],
        ),
      ),
    );
  }
}
