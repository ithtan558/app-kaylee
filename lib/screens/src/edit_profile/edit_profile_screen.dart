import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/reset_pass/reset_pass_screen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  factory EditProfileScreen.newInstance() = EditProfileScreen._;

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
        appBar: KayleeAppBar(
          title: Strings.chinhSuThongTinCaNhan,
          actions: [
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(right: Dimens.px16),
              alignment: Alignment.centerRight,
              child: HyperLinkText(
                text: Strings.luu,
                onTap: () {},
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.px16),
          child: Column(
            children: [
              KayleeImagePicker(
                image: 'https://kottke.org/plus/misc/images/ai-faces-01.jpg',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeTextField(
                        title: Strings.ho,
                        textInput: NormalInputField(
                          hint: Strings.hoHint,
                          controller: lastNameTfController,
                          textInputAction: TextInputAction.next,
                          focusNode: lastNameFocus,
                          nextFocusNode: nameFocus,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimens.px16),
                    Expanded(
                      child: KayleeTextField(
                        title: Strings.ten,
                        textInput: NormalInputField(
                          hint: Strings.tenHint,
                          controller: nameTfController,
                          textInputAction: TextInputAction.next,
                          focusNode: nameFocus,
                          nextFocusNode: addrFocus,
                        ),
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
                child: KayleeTextField(
                  title: Strings.namSinh,
                  textInput: SelectionInputField(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px16),
                child: KayleeTextField(
                  title: Strings.queQuan,
                  textInput: SelectionInputField(
                    hint: Strings.chonTinhTpHint,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px8),
                child: KayleeTextField(
                  title: Strings.diaChiHienTai,
                  textInput: NormalInputField(
                    hint: Strings.diaChiHienTaiHint,
                    controller: addrTfController,
                    focusNode: addrFocus,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px8),
                child: Row(
                  children: [
                    Expanded(
                        child: KayleeTextField(
                      textInput: SelectionInputField(
                        hint: Strings.phuong,
                      ),
                    )),
                    SizedBox(width: Dimens.px8),
                    Expanded(
                        child: KayleeTextField(
                      textInput: SelectionInputField(
                        hint: Strings.quan,
                      ),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px16),
                child: KayleeTextField(
                  textInput: SelectionInputField(
                    hint: Strings.chonTinhTpHint,
                  ),
                ),
              ),
              KayleeTextField(
                title: Strings.matKhau,
                textInput: ButtonInputField(
                  initText: 'Cập nhật 19:00 12/03/2019',
                  buttonText: Strings.doiMatKhau,
                  onTap: () {
                    pushScreen(PageIntent(context, ResetPassScreen));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
