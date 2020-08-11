import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ReceiverInfoScreen extends StatefulWidget {
  static Widget newInstance() => ReceiverInfoScreen._();

  ReceiverInfoScreen._();

  @override
  _ReceiverInfoScreenState createState() => new _ReceiverInfoScreenState();
}

class _ReceiverInfoScreenState extends BaseState<ReceiverInfoScreen> {
  final nameTfController = TextEditingController();
  final phoneTfController = TextEditingController();
  final noteTfController = TextEditingController();
  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final noteFocus = FocusNode();
  KayleeFullAddressController addressController;

  @override
  void initState() {
    super.initState();
    nameTfController.text = context.cart.getOrder().cartSuppInfo?.name;
    addressController = KayleeFullAddressController(
        initAddress: context.cart.getOrder().cartSuppInfo?.address,
        initCity: context.cart.getOrder().cartSuppInfo?.city,
        initDistrict: context.cart.getOrder().cartSuppInfo?.district,
        initWard: context.cart.getOrder().cartSuppInfo?.ward);
    phoneTfController.text = context.cart.getOrder().cartSuppInfo?.phone;
    noteTfController.text = context.cart.getOrder().cartSuppInfo?.note;
  }

  @override
  void dispose() {
    nameTfController.dispose();
    phoneTfController.dispose();
    noteTfController.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    noteFocus.dispose();
    super.dispose();
  }

  void saveInfo() {
    context.cart.updateOrderInfo(context.cart.getOrder()
      ..cartSuppInfo = CartSuppInfo(
        name: nameTfController.text,
        address: addressController.address,
        city: addressController.city,
        district: addressController.district,
        ward: addressController.ward,
        phone: phoneTfController.text,
        note: noteTfController.text,
      ));
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
                child: KayleeTextField.normal(
                  title: Strings.hoVaTen,
                  hint: Strings.nhapHoVaTen,
                  controller: nameTfController,
                  focusNode: nameFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),
              KayleeFullAddressInput(
                title: Strings.diaChiHienTai,
                padding: EdgeInsets.all(Dimens.px16),
                controller: addressController,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
                child: KayleeTextField.phoneInput(
                  title: Strings.soDienThoai,
                  controller: phoneTfController,
                  focusNode: phoneFocus,
                  nextFocusNode: noteFocus,
                  textInputAction: TextInputAction.next,
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
                  contentPadding: EdgeInsets.symmetric(vertical: Dimens.px16),
                  maxLength: 200,
                  focusNode: noteFocus,
                ),
              ),
            ],
          ),
          bottom: KayLeeRoundedButton.normal(
            text: Strings.tiepTuc,
            margin: EdgeInsets.all(Dimens.px8),
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
