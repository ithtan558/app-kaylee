import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:kaylee/screens/src/reset_pass/reset/reset_pass_verify_phone_screen.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => EditProfileBloc(
            userInfo: context.user.getUserInfo()?.userInfo,
            userService: context.network.provideUserService(),
          ),
      child: EditProfileScreen._());

  EditProfileScreen._();

  @override
  _EditProfileScreenState createState() => new _EditProfileScreenState();
}

class _EditProfileScreenState extends KayleeState<EditProfileScreen> {
  final imagePickerController = ImagePickerController();
  final lastNameTfController = TextEditingController();
  final firstNameTfController = TextEditingController();
  final lastNameFocus = FocusNode();
  final firstNameFocus = FocusNode();
  final birthDayController = PickInputController<DateTime>();
  final addressController = KayleeFullAddressController();

  EditProfileBloc _bloc;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<EditProfileBloc>();
    _sub = _bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
        } else if (state is UpdateProfileModel) {
          showKayleeAlertMessageYesDialog(
              context: context, message: state.message, onPressed: popScreen);
        }
      }
    });
    _bloc.loadProfile();
  }

  @override
  void dispose() {
    lastNameTfController.dispose();
    firstNameTfController.dispose();

    lastNameFocus.dispose();
    firstNameFocus.dispose();
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: Strings.chinhSuThongTinCaNhan,
          onActionClick: () {
            showKayleeAlertDialog(
                context: context,
                view: KayleeAlertDialogView(
                  title: Strings.banDaChacChan,
                  content: Strings.banCoDongYLuuLaiNhungThayDoi,
                  actions: [
                    KayleeAlertDialogAction.dongY(
                      onPressed: () {
                        popScreen();
                        _bloc.userInfo
                          ..firstName = firstNameTfController.text
                          ..lastName = lastNameTfController.text
                          ..birthday = birthDayController.value.toString()
                          ..address = addressController.address
                          ..city = addressController.city
                          ..district = addressController.district
                          ..wards = addressController.ward
                          ..imageFile = imagePickerController.image;
                        _bloc.updateProfile();
                      },
                      isDefaultAction: true,
                    ),
                    KayleeAlertDialogAction.huy(
                      onPressed: popScreen,
                    ),
                  ],
                ));
          },
          actionTitle: Strings.luu,
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocBuilder<EditProfileBloc, SingleModel<UserInfo>>(
          buildWhen: (previous, current) => current is ProfileModel,
          builder: (context, state) {
            imagePickerController.existedImageUrl = state.item?.image;
            firstNameTfController.text = state.item?.firstName;
            lastNameTfController.text = state.item?.lastName;

            birthDayController.value = state.item?.birthdayInDateTime;
            addressController
              ..initAddress = state.item?.address
              ..initCity = state.item?.city
              ..initDistrict = state.item?.district
              ..initWard = state.item?.wards;
            return Column(
              children: [
                KayleeImagePicker(
                  controller: imagePickerController,
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
                          nextFocusNode: firstNameFocus,
                        ),
                      ),
                      SizedBox(width: Dimens.px8),
                      Expanded(
                        child: KayleeTextField.normal(
                          title: Strings.ten,
                          hint: Strings.tenHint,
                          controller: firstNameTfController,
                          textInputAction: TextInputAction.done,
                          focusNode: firstNameFocus,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.staticPhone(
                    title: Strings.soDienThoai,
                    initText: state.item?.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.staticWidget(
                    title: Strings.email,
                    initText: state.item?.email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleePickerTextField<DateTime>(
                    title: Strings.ngaySinh,
                    hint: Strings.chonNgayThangNam,
                    controller: birthDayController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeFullAddressInput(
                    key: UniqueKey(),
                    title: Strings.diaChiHienTai,
                    controller: addressController,
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
            );
          },
        ),
      ),
    );
  }
}
