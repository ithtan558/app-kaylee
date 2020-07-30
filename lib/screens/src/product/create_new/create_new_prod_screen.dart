import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
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

class _CreateNewProdScreenState extends KayleeState<CreateNewProdScreen> {
  NewProdScreenOpenFrom openFrom;
  ProdDetailScreenBloc bloc;
  StreamSubscription prodDetailScreenBlocSub;
  String image;
  final bannerPickerController = ImagePickerController();
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();
  final brandSelectController = BrandSelectTFController();
  final priceTfController = TextEditingController();
  final priceFocus = FocusNode();
  final descriptionTfController = TextEditingController();
  final descriptionFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<ProdDetailScreenBloc>();
    prodDetailScreenBlocSub = bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: () {
              popScreen();
//              switch (state.error.code) {
//                case ErrorCode.PHONE_CODE:
//                  phoneFocus.requestFocus();
//                  break;
//              }
            },
          );
        } else if (state.message.isNotNull) {
          showKayleeAlertMessageYesDialog(
              context: context,
              message: state.message,
              onPressed: popScreen,
              onDismiss: popScreen);
        }
      }
    });
    final data = context.getArguments<NewProdScreenData>();
    openFrom = data?.openFrom;
    if (openFrom == NewProdScreenOpenFrom.prodItem) {
      bloc.get();
    }
  }

  @override
  void dispose() {
    prodDetailScreenBlocSub.cancel();
    nameTfController.dispose();
    nameFocus.dispose();
    priceTfController.dispose();
    priceFocus.dispose();
    descriptionTfController.dispose();
    descriptionFocus.dispose();
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
          onActionClick: () {
            if (openFrom == NewProdScreenOpenFrom.prodItem) {
              showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView(
                    title: Strings.banDaChacChan,
                    content: Strings.banCoDongYLuuLaiNhungThayDoi,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: () {
                          popScreen();
                          bloc.state.item
                            ..name = nameTfController.text
                            ..brands = brandSelectController.brands
                            ..price = int.tryParse(priceTfController.text)
//                            ..category
                            ..description = descriptionTfController.text
                            ..imageFile = bannerPickerController.image;
                          bloc.update();
                        },
                        isDefaultAction: true,
                      ),
                      KayleeAlertDialogAction.huy(
                        onPressed: popScreen,
                      ),
                    ],
                  ));
            } else {
              bloc.state.item = Product(
                  name: nameTfController.text,
                  brands: brandSelectController.brands,
                  price: int.tryParse(priceTfController.text),
//                  category: ,
                  description: descriptionTfController.text,
                  imageFile: bannerPickerController.image);
              bloc.create();
            }
          },
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocBuilder<ProdDetailScreenBloc, SingleModel<Product>>(
          buildWhen: (previous, current) => !current.loading,
          builder: (context, state) {
            image = state.item?.image;
            nameTfController.text = state.item?.name;
            brandSelectController.brands = state.item?.brands;
            priceTfController.text = state.item?.price?.toString();
            descriptionTfController.text = state.item?.description;
            return Column(
              children: [
                KayleeImagePicker(
                  image: image,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.tenSanPham,
                    hint: Strings.nhapTenSanPham,
                    controller: nameTfController,
                    focusNode: nameFocus,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: priceFocus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: BrandSelectTextField(
                    title: Strings.diaDiemBanSanPham,
                    controller: brandSelectController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.price(
                    title: Strings.giaTien,
                    hint: '0',
                    textInputAction: TextInputAction.next,
                    controller: priceTfController,
                    focusNode: priceFocus,
                    nextFocusNode: descriptionFocus,
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
                  controller: descriptionTfController,
                  focusNode: descriptionFocus,
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
            );
          },
        ),
      ),
    );
  }
}
