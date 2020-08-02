import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/brand_select_textfield/brand_select_list.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewServiceScreenData {
  final ServiceScreenOpenFrom openFrom;
  final Service service;

  NewServiceScreenData({this.openFrom, this.service});
}

enum ServiceScreenOpenFrom { serviceItem, addNewServiceBtn }

class CreateNewServiceScreen extends StatefulWidget {
  static Widget newInstance() => CreateNewServiceScreen._();

  CreateNewServiceScreen._();

  @override
  _CreateNewServiceScreenState createState() => _CreateNewServiceScreenState();
}

class _CreateNewServiceScreenState extends BaseState<CreateNewServiceScreen> {
  ServiceScreenOpenFrom openFrom;

  @override
  void initState() {
    super.initState();
    final data = context.getArguments<NewServiceScreenData>();
    openFrom = data?.openFrom;
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == ServiceScreenOpenFrom.serviceItem
              ? Strings.chinhSuaDichVu
              : Strings.taoDichVuMoi,
          actionTitle: openFrom == ServiceScreenOpenFrom.serviceItem
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
              child: KayleeTextField.normal(
                title: Strings.tenDichVu,
                hint: Strings.nhapTenDichVu,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleeTextField.selection(
                title: Strings.diaDiemSuDungDichVu,
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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: KayleePickerTextField(
                title: Strings.thoiGianPhucVu,
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
              child: KayleePickerTextField(
                title: Strings.loaiDichVu,
                hint: Strings.chonLoaiDichVu,
              ),
            ),
            KayleeTextField.multiLine(
              title: Strings.moTa,
              hint: Strings.nhapMoTaDichVu,
              textInputAction: TextInputAction.newline,
              fieldHeight:
                  (context.screenSize.width - Dimens.px32) / (343 / 233),
              contentPadding: EdgeInsets.symmetric(vertical: Dimens.px16),
            ),
            if (openFrom == ServiceScreenOpenFrom.serviceItem)
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px32, bottom: Dimens.px16),
                child: HyperLinkText(
                  text: Strings.xoaDichVu,
                  onTap: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
