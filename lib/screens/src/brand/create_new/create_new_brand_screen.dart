import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/brand/create_new/bloc/brand_detail_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/kaylee_picker_textfield.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewBrandScreenData {
  final BrandScreenOpenFrom openFrom;
  final Brand brand;

  NewBrandScreenData({this.brand, this.openFrom});
}

enum BrandScreenOpenFrom { brandItem, addNewBrandBtn }

class CreateNewBrandScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<BrandDetailScreenBloc>(
        create: (context) => BrandDetailScreenBloc(
            brandService: context.network.provideBrandService(),
            brand: context.getArguments<NewBrandScreenData>().brand),
        child: CreateNewBrandScreen._(),
      );

  CreateNewBrandScreen._();

  @override
  _CreateNewBrandScreenState createState() => _CreateNewBrandScreenState();
}

class _CreateNewBrandScreenState extends KayleeState<CreateNewBrandScreen> {
  BrandScreenOpenFrom openFrom;
  final startTimeController = PickInputController<StartTime>();
  final endTimeController = PickInputController<EndTime>();
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();
  final addressController = KayleeFullAddressController();
  final phoneTfController = TextEditingController();
  final phoneFocus = FocusNode();

  BrandDetailScreenBloc get bloc => context.bloc<BrandDetailScreenBloc>();
  StreamSubscription brandDetailScreenBlocSub;
  final bannerPickerController = ImagePickerController();

  @override
  void initState() {
    super.initState();
    brandDetailScreenBlocSub = bloc.listen((state) {
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
              switch (state.error.code) {
                case ErrorCode.PHONE_CODE:
                  phoneFocus.requestFocus();
                  break;
              }
            },
          );
        } else if (state is DeleteBrandModel ||
            state is NewBrandModel ||
            state is UpdateBrandModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>().reload(widget: BrandListScreen);
              popScreen();
            },
          );
        }
      }
    });
    final data = context.getArguments<NewBrandScreenData>();
    openFrom = data?.openFrom;
    if (openFrom == BrandScreenOpenFrom.brandItem) {
      bloc.get();
    }
  }

  @override
  void dispose() {
    brandDetailScreenBlocSub.cancel();
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
          title: openFrom == BrandScreenOpenFrom.brandItem
              ? Strings.chinhSuaChiNhanh
              : Strings.taoChiNhanhMoi,
          actions: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: Dimens.px16),
              child: HyperLinkText(
                text: openFrom == BrandScreenOpenFrom.brandItem
                    ? Strings.luu
                    : Strings.tao,
                onTap: () {
                  if (openFrom == BrandScreenOpenFrom.brandItem) {
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
                                  ..phone = phoneTfController.text
                                  ..location = addressController.address
                                  ..city = addressController.city
                                  ..district = addressController.district
                                  ..startTime = startTimeController.value.time
                                  ..endTime = endTimeController.value.time
                                  ..wards = addressController.ward
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
                    bloc.state.item = Brand(
                        name: nameTfController.text,
                        phone: phoneTfController.text,
                        location: addressController.address,
                        city: addressController.city,
                        district: addressController.district,
                        startTime: startTimeController.value?.time,
                        endTime: endTimeController.value?.time,
                        wards: addressController.ward,
                        imageFile: bannerPickerController.image);
                    bloc.create();
                  }
                },
              ),
            )
          ],
        ),
        child: BlocConsumer<BrandDetailScreenBloc, SingleModel<Brand>>(
          listener: (context, state) {
            bannerPickerController.existedImageUrl = state.item?.image;
            nameTfController.text = state.item?.name;
            addressController
              ..initAddress = state.item?.location
              ..initCity = state.item?.city
              ..initDistrict = state.item?.district
              ..initWard = state.item?.wards;
            phoneTfController.text = state.item?.phone;
            startTimeController.value = state.item?.start;
            endTimeController.value = state.item?.end;
          },
          listenWhen: (previous, current) => current is DetailBrandModel,
          buildWhen: (previous, current) => current is DetailBrandModel,
          builder: (context, state) {
            return Column(
              children: [
                KayleeImagePicker(
                  type: KayleeImagePickerType.banner,
                  controller: bannerPickerController,
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
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleeFullAddressInput(
                    title: Strings.diaChi,
                    controller: addressController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleeTextField.phoneInput(
                    textInputAction: TextInputAction.done,
                    focusNode: phoneFocus,
                    controller: phoneTfController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
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
                if (openFrom == BrandScreenOpenFrom.brandItem)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Dimens.px16, bottom: Dimens.px32),
                    child: HyperLinkText(
                      text: Strings.xoaChiNhanh,
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
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
