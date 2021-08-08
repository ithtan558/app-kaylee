import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier/receiver_info/bloc/auto_fill_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ReceiverInfoScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) =>
          AutoFillBloc(service: locator.apis.provideBrandApi()),
      child: const ReceiverInfoScreen._());

  const ReceiverInfoScreen._();

  @override
  _ReceiverInfoScreenState createState() => _ReceiverInfoScreenState();
}

class _ReceiverInfoScreenState extends KayleeState<ReceiverInfoScreen> {
  final brandController = PickInputController<Brand>();
  final nameTfController = TextEditingController();
  final phoneTfController = TextEditingController();
  final noteTfController = TextEditingController();
  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final noteFocus = FocusNode();
  late KayleeFullAddressController addressController;
  late StreamSubscription _autoFillBlocSub;

  AutoFillBloc get autoFillBloc => context.bloc<AutoFillBloc>()!;

  @override
  void initState() {
    super.initState();
    nameTfController.text = context.cart.getOrder()?.cartSuppInfo?.name ?? '';
    addressController = KayleeFullAddressController(
        initAddress: context.cart.getOrder()?.cartSuppInfo?.address,
        initCity: context.cart.getOrder()?.cartSuppInfo?.city,
        initDistrict: context.cart.getOrder()?.cartSuppInfo?.district,
        initWard: context.cart.getOrder()?.cartSuppInfo?.ward);
    phoneTfController.text = context.cart.getOrder()?.cartSuppInfo?.phone ?? '';
    noteTfController.text = context.cart.getOrder()?.cartSuppInfo?.note ?? '';
    brandController.value = context.cart.getOrder()?.brand;

    _autoFillBlocSub = autoFillBloc.stream.listen((state) {
      if (state.loading) return showLoading();
      if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
        }
      }
    });
  }

  @override
  void dispose() {
    _autoFillBlocSub.cancel();
    nameTfController.dispose();
    phoneTfController.dispose();
    noteTfController.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    noteFocus.dispose();
    super.dispose();
  }

  void saveInfo() {
    context.cart.updateOrderInfo((context.cart.getOrder()
      ?..cartSuppInfo = CartSuppInfo(
        name: nameTfController.text,
        address: addressController.address,
        city: addressController.city,
        district: addressController.district,
        ward: addressController.ward,
        phone: phoneTfController.text,
        note: noteTfController.text,
      ))
      ?..brand = brandController.value);
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: WillPopScope(
        onWillPop: () async {
          saveInfo();
          return true;
        },
        child: KayleeScrollview(
          appBar: KayleeAppBar(
            title: Strings.thongTinNguoiNhan,
            onBack: () {
              return true;
            },
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16, right: Dimens.px16, left: Dimens.px16),
                child: KayleePickerTextField(
                  title: Strings.chiNhanh,
                  hint: Strings.chonChiNhanhTrongDs,
                  controller: brandController,
                  onSelect: (value) {
                    context.bloc<AutoFillBloc>()!.loadBrandInfo(brand: value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16, right: Dimens.px16, left: Dimens.px16),
                child: KayleeTextField.normal(
                  title: Strings.hoVaTen,
                  hint: Strings.nhapHoVaTen,
                  controller: nameTfController,
                  focusNode: nameFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),
              BlocConsumer<AutoFillBloc, SingleModel<Brand>>(
                buildWhen: (previous, current) => current is DetailBrandModel,
                listenWhen: (previous, current) => current is DetailBrandModel,
                listener: (context, state) {
                  addressController
                    ..initAddress =
                        state.item?.location ?? addressController.initAddress
                    ..initCity = state.item?.city ?? addressController.initCity
                    ..initDistrict =
                        state.item?.district ?? addressController.district
                    ..initWard =
                        state.item?.wards ?? addressController.initWard;
                },
                builder: (context, state) {
                  return KayleeFullAddressInput(
                    title: Strings.diaChiHienTai,
                    padding: const EdgeInsets.all(Dimens.px16),
                    controller: addressController,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: BlocConsumer<AutoFillBloc, SingleModel<Brand>>(
                  buildWhen: (previous, current) => current is DetailBrandModel,
                  listenWhen: (previous, current) =>
                      current is DetailBrandModel,
                  listener: (context, state) {
                    phoneTfController.text =
                        state.item?.phone ?? phoneTfController.text;
                  },
                  builder: (context, state) {
                    return KayleeTextField.phoneInput(
                      title: Strings.soDienThoai,
                      controller: phoneTfController,
                      focusNode: phoneFocus,
                      nextFocusNode: noteFocus,
                      textInputAction: TextInputAction.next,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: KayleeTextField.multiLine(
                  title: Strings.luuY,
                  hint: Strings.luuYHint,
                  textInputAction: TextInputAction.newline,
                  controller: noteTfController,
                  fieldHeight:
                      (context.screenSize.width - Dimens.px32) / (343 / 233),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: Dimens.px16),
                  maxLength: 200,
                  focusNode: noteFocus,
                ),
              ),
            ],
          ),
          bottom: KayLeeRoundedButton.normal(
            text: Strings.tiepTuc,
            margin: const EdgeInsets.all(Dimens.px8),
            onPressed: () {
              saveInfo();
              pushScreen(PageIntent(screen: PaymentInfoScreen));
            },
          ),
        ),
      ),
    );
  }
}
