import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/kaylee_picker_textfield.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewBranchScreenData {
  final BranchScreenOpenFrom openFrom;
  final Brand branch;

  NewBranchScreenData({this.branch, this.openFrom});
}

enum BranchScreenOpenFrom { branchItem, addNewBranchBtn }

class CreateNewBranchScreen extends StatefulWidget {
  static Widget newInstance() => CreateNewBranchScreen._();

  CreateNewBranchScreen._();

  @override
  _CreateNewBranchScreenState createState() => _CreateNewBranchScreenState();
}

class _CreateNewBranchScreenState extends BaseState<CreateNewBranchScreen> {
  BranchScreenOpenFrom openFrom;
  final startTimeController = PickInputController<StartTime>();
  final endTimeController = PickInputController<EndTime>();
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();
  final addressController = KayleeFullAddressController();
  final phoneTfController = TextEditingController();
  final phoneFocus = FocusNode();
  String banner;

  @override
  void initState() {
    super.initState();
    final data = context.getArguments<NewBranchScreenData>();
    openFrom = data?.openFrom;
    if (openFrom == BranchScreenOpenFrom.branchItem && data.branch.isNotNull) {
      banner = data.branch.image;
      nameTfController.text = data.branch.name ?? '';
      addressController
        ..initAddress = data.branch.location ?? ''
        ..initCity = data.branch.city
        ..initDistrict = data.branch.district
        ..initWard = data.branch.wards;
      phoneTfController.text = data.branch.phone ?? '';
      startTimeController.value = data.branch.start;
      endTimeController.value = data.branch.end;
    }
  }

  @override
  void dispose() {
    nameTfController.dispose();
    phoneTfController.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          title: openFrom == BranchScreenOpenFrom.branchItem
              ? Strings.chinhSuaChiNhanh
              : Strings.taoChiNhanhMoi,
          actions: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: Dimens.px16),
              child: HyperLinkText(
                text: openFrom == BranchScreenOpenFrom.branchItem
                    ? Strings.luu
                    : Strings.tao,
                onTap: () {},
              ),
            )
          ],
        ),
        child: Column(
          children: [
            KayleeImagePicker(
              type: KayleeImagePickerType.banner,
              image: banner,
              onImageSelect: (file, {existedImage}) {},
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.px16),
              child: KayleeTextField.normal(
                title: Strings.tenCuaHang,
                hint: Strings.tenCuaHangHint,
                controller: nameTfController,
                focusNode: nameFocus,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: KayleeFullAddressInput(
                title: Strings.diaChi,
                controller: addressController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: KayleeTextField.phoneInput(
                title: Strings.soDienThoai,
                textInputAction: TextInputAction.done,
                focusNode: phoneFocus,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayleePickerTextField<StartTime>(
                      title: Strings.gioMoCua,
                      controller: startTimeController,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleePickerTextField<EndTime>(
                      title: Strings.gioDongCua,
                      controller: endTimeController,
                    ),
                  )
                ],
              ),
            ),
            if (openFrom == BranchScreenOpenFrom.branchItem)
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16, bottom: Dimens.px32),
                child: HyperLinkText(
                  text: Strings.xoaChiNhanh,
                  onTap: () {},
                ),
              )
          ],
        ),
      ),
    );
  }
}
