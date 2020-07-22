import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/kaylee_picker_textfield.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewBranchScreenData {
  final BranchScreenOpenFrom openFrom;

  NewBranchScreenData({this.openFrom});
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

  @override
  void initState() {
    super.initState();
    final data = context.getArguments() as NewBranchScreenData;
    openFrom = data?.openFrom;
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
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.px16),
              child: KayleeTextField.normal(
                title: Strings.tenCuaHang,
                hint: Strings.tenCuaHangHint,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: KayleeFullAddressInput(
                title: Strings.diaChi,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: KayleeTextField.phoneInput(
                title: Strings.soDienThoai,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayleePickerTextField(
                      title: Strings.gioMoCua,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleePickerTextField(
                      title: Strings.gioDongCua,
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
