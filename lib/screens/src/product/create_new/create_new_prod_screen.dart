import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
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
  final bannerPickerController = ImagePickerController();
  final codeTfController = TextEditingController();
  final codeFocus = FocusNode();
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();
  final brandSelectController = BrandSelectTFController();
  final priceTfController = MoneyMaskedTextController(
    thousandSeparator: '.',
    precision: 0,
    decimalSeparator: '',
  );
  final priceFocus = FocusNode();
  final descriptionTfController = TextEditingController();
  final descriptionFocus = FocusNode();
  final prodCateController = PickInputController<ProdCate>();

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
          if (state.error.code.isNull) {
            showKayleeAlertErrorYesDialog(
              context: context,
              error: state.error,
              onPressed: popScreen,
            );
          } else {
            switch (state.error.code) {
              case ErrorCode.NAME_CODE:
                nameFocus.requestFocus();
                break;
              case ErrorCode.PRICE_CODE:
                priceFocus.requestFocus();
                break;
              case ErrorCode.CODE_CODE:
                codeFocus.requestFocus();
                break;
            }
          }
        } else if (state is NewProdDetailModel ||
            state is DeleteProdDetailModel ||
            state is UpdateProdDetailModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>().reload(widget: ProdListScreen);
              popScreen();
            },
          );
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
    codeTfController.dispose();
    codeFocus.dispose();
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
                            ..code = codeTfController.text
                            ..name = nameTfController.text
                            ..brands = brandSelectController.brands
                            ..price = int.tryParse(
                                priceTfController.text.replaceAll('.', ''))
                            ..category = prodCateController.value
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
                  code: codeTfController.text,
                  name: nameTfController.text,
                  brands: brandSelectController.brands,
                  price:
                      int.tryParse(priceTfController.text.replaceAll('.', '')),
                  category: prodCateController.value,
                  description: descriptionTfController.text,
                  imageFile: bannerPickerController.image);
              bloc.create();
            }
          },
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocConsumer<ProdDetailScreenBloc, SingleModel<Product>>(
          listenWhen: (previous, current) => current is ProdDetailModel,
          listener: (context, state) {
            bannerPickerController?.existedImageUrl = state.item?.image;
            codeTfController.text = state.item?.code;
            nameTfController.text = state.item?.name;
            brandSelectController.brands = state.item?.brands;
            priceTfController.text = state.item?.price?.toString();
            prodCateController.value = state.item?.category;
            descriptionTfController.text = state.item?.description;
          },
          buildWhen: (previous, current) => current is ProdDetailModel,
          builder: (context, state) {
            return Column(
              children: [
                KayleeImagePicker(
                  controller: bannerPickerController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.maSanPham,
                    hint: Strings.nhapMaSanPham,
                    controller: codeTfController,
                    focusNode: codeFocus,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: nameFocus,
                    error: state.error?.code.isNotNull &&
                        state.error.code == ErrorCode.CODE_CODE
                        ? state.error.message
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.tenSanPham,
                    hint: Strings.nhapTenSanPham,
                    controller: nameTfController,
                    focusNode: nameFocus,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: priceFocus,
                    error: state.error?.code.isNotNull &&
                        state.error.code == ErrorCode.NAME_CODE
                        ? state.error.message
                        : null,
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
                      error: state.error?.code.isNotNull &&
                          state.error.code == ErrorCode.PRICE_CODE
                          ? state.error.message
                          : null),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleePickerTextField<ProdCate>(
                    title: Strings.loaiSanPham,
                    hint: Strings.chonLoaiSanPham,
                    controller: prodCateController,
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
                      onTap: () {
                        showKayleeAlertDialog(
                            context: context,
                            view: KayleeAlertDialogView(
                              title: Strings.banDaChacChan,
                              content: Strings
                                  .banCoDongYXoaThongTinVaKhongPhucHoiLai,
                              actions: [
                                KayleeAlertDialogAction.dongY(
                                  onPressed: () {
                                    popScreen();
                                    bloc.delete();
                                  },
                                  isDefaultAction: true,
                                ),
                                KayleeAlertDialogAction.huy(
                                  onPressed: popScreen,
                                ),
                              ],
                            ));
                      },
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
