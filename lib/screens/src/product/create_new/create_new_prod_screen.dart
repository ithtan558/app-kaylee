import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/branch/widgets/branch_select.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class NewProdScreenData {
  final NewProdScreenOpenFrom openFrom;

  NewProdScreenData({this.openFrom});
}

enum NewProdScreenOpenFrom { prodItem, addNewProdBtn }

class CreateNewProdScreen extends StatefulWidget {
  static Widget newInstance() => CreateNewProdScreen._();

  CreateNewProdScreen._();

  @override
  _CreateNewProdScreenState createState() => _CreateNewProdScreenState();
}

class _CreateNewProdScreenState extends BaseState<CreateNewProdScreen> {
  NewProdScreenOpenFrom openFrom;

  @override
  void initState() {
    super.initState();
    final data = bundle.args as NewProdScreenData;
    openFrom = data?.openFrom;
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == NewProdScreenOpenFrom.prodItem
              ? Strings.chinhSuaSanPham
              : Strings.taoSanPhamMoi,
          actionTitle: openFrom == NewProdScreenOpenFrom.prodItem
              ? Strings.luu
              : Strings.tao,
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
              child: KayleeTextField.normal(
                title: Strings.tenSanPham,
                hint: Strings.nhapTenSanPham,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeTextField.selection(
                title: Strings.diaDiemBanSanPham,
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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: KayleeTextField.picker(
                      title: Strings.ngayBatDau,
                      hint: Strings.chonNgay,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleeTextField.picker(
                      title: Strings.ngayKetThuc,
                      hint: Strings.chonNgay,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeTextField.price(
                title: Strings.giaTien,
                hint: '0',
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeTextField.picker(
                title: Strings.loaiSanPham,
                hint: Strings.chonLoaiSanPham,
              ),
            ),
            KayleeTextField.multiLine(
              title: Strings.moTa,
              hint: Strings.nhapMoTaSanPham,
              textInputAction: TextInputAction.newline,
              fieldHeight:
                  (context.screenSize.width - Dimens.px32) / (343 / 233),
              contentPadding: EdgeInsets.symmetric(vertical: Dimens.px16),
            ),
            if (openFrom == NewProdScreenOpenFrom.prodItem)
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px32, bottom: Dimens.px16),
                child: HyperLinkText(
                  text: Strings.xoaSanPham,
                  onTap: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
