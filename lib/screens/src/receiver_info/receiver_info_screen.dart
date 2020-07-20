import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
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

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          title: Strings.thongTinNguoiNhan,
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
          onPressed: () {},
        ),
      ),
    );
  }
}
