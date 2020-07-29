import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/brand/widgets/brand_select.dart';
import 'package:kaylee/screens/src/product/create_new/bloc/prod_detail_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewProdScreenData {
  final NewProdScreenOpenFrom openFrom;
  final Product product;

  NewProdScreenData({this.openFrom, this.product});
}

enum NewProdScreenOpenFrom { prodItem, addNewProdBtn }

class CreateNewProdScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<ProdDetailScreenBloc>(
        create: (context) => ProdDetailScreenBloc(
            prodService: context.network.provideProductService(),
            product: context.getArguments<NewProdScreenData>().product),
        child: CreateNewProdScreen._(),
      );

  CreateNewProdScreen._();

  @override
  _CreateNewProdScreenState createState() => _CreateNewProdScreenState();
}

class _CreateNewProdScreenState extends BaseState<CreateNewProdScreen> {
  NewProdScreenOpenFrom openFrom;
  ProdDetailScreenBloc bloc;
  StreamSubscription prodDetailScreenBlocSub;
  String image;
  final bannerPickerController = ImagePickerController();
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    final data = context.bundle.args as NewProdScreenData;
    openFrom = data?.openFrom;
  }

  @override
  void dispose() {
    prodDetailScreenBlocSub.cancel();
    nameTfController.dispose();
    nameFocus.dispose();
    super.dispose();
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

              image: image,
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
                      return BrandSelect(controller: controller);
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
                    child: KayleePickerTextField(
                      title: Strings.ngayBatDau,
                      hint: Strings.chonNgay,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleePickerTextField(
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
              child: KayleePickerTextField(
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
