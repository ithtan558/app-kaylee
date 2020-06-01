import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class InputNewPassScreen extends StatefulWidget {
  factory InputNewPassScreen.newInstance() = InputNewPassScreen._;

  InputNewPassScreen._();

  @override
  _InputNewPassScreenState createState() => new _InputNewPassScreenState();
}

class _InputNewPassScreenState extends BaseState<InputNewPassScreen> {
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
        title: Strings.nhapMatKhauMoi,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: Dimens.px16,
            bottom: Dimens.px32,
            left: Dimens.px16,
            right: Dimens.px16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KayleeTextField.password(
              title: Strings.matKhauMoi,
              textInputAction: TextInputAction.done,
              hint: Strings.passLimitHint,
            ),
            KayLeeRoundedButton.normal(
              margin: EdgeInsets.only(top: Dimens.px16),
              onPressed: () {
//                pushScreen(PageIntent(context, ));
              },
              text: Strings.xacNhan,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Câu hỏi khác về đăng nhập/đăng ký?',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.px8),
                  child: HyperLinkText(
                    text: Strings.lienHeChungToi,
                    onTap: () {},
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
