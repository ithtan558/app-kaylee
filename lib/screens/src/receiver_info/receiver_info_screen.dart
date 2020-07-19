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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar(
          title: Strings.thongTinNguoiNhan,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16, right: Dimens.px16, left: Dimens.px16),
                child: KayleeTextField.normal(
                  title: Strings.hoVaTen,
                  hint: Strings.nhapHoVaTen,
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
                ),
              ),
              KayLeeRoundedButton.normal(
                text: Strings.tiepTuc,
                margin: EdgeInsets.all(Dimens.px8),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
