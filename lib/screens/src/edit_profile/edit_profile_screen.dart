import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/reset_pass/reset/reset_pass_verify_phone_screen.dart';
import 'package:kaylee/widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  static Widget newInstance() => EditProfileScreen._();

  EditProfileScreen._();

  @override
  _EditProfileScreenState createState() => new _EditProfileScreenState();
}

class _EditProfileScreenState extends BaseState<EditProfileScreen> {
  final lastNameTfController = TextEditingController();
  final nameTfController = TextEditingController();
  final addrTfController = TextEditingController();
  final lastNameFocus = FocusNode();
  final nameFocus = FocusNode();
  final addrFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    lastNameTfController.dispose();
    nameTfController.dispose();
    addrTfController.dispose();

    lastNameFocus.dispose();
    nameFocus.dispose();
    addrFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar.hyperTextAction(
          title: Strings.chinhSuThongTinCaNhan,
          onActionClick: () {},
          actionTitle: Strings.luu,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.px16),
          child: Column(
            children: [
              KayleeImagePicker(
                image: 'https://kottke.org/plus/misc/images/ai-faces-01.jpg',
                oldImages: [
                  'https://us.123rf.com/450wm/subbotina/subbotina1512/subbotina151200067/49609375-beautiful-spa-model-girl-with-perfect-fresh-clean-skin.jpg?ver=6',
                  'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  'https://i.pinimg.com/originals/97/e4/2a/97e42a82fc7911961d3ca55f54d1372c.jpg',
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeTextField.normal(
                        title: Strings.ho,
                        hint: Strings.hoHint,
                        controller: lastNameTfController,
                        textInputAction: TextInputAction.next,
                        focusNode: lastNameFocus,
                      ),
                    ),
                    SizedBox(width: Dimens.px8),
                    Expanded(
                      child: KayleeTextField.normal(
                        title: Strings.ten,
                        hint: Strings.tenHint,
                        controller: nameTfController,
                        textInputAction: TextInputAction.next,
                        focusNode: nameFocus,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px16),
                child: KayleeTextField(
                  title: Strings.soDienThoai,
                  textInput: PhoneInputField.static(
                    initText: '7738 7738',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px16),
                child: KayleeTextField.staticWidget(
                  title: Strings.soDienThoai,
                  initText: 'david.cop20@gmail.com',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px16),
                child: KayleePickerTextField(
                  title: Strings.ngaySinh,
                  hint: Strings.chonNgayThangNam,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px16),
                child: KayleeFullAddressInput(
                  title: Strings.diaChiHienTai,
                ),
              ),
              KayleeTextField.selection(
                title: Strings.matKhau,
                buttonText: Strings.doiMatKhau,
                onPress: () {
                  pushScreen(PageIntent(screen: ResetPassVerifyPhoneScreen));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
