import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/staff/create_new/bloc/staff_detail_screen_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewStaffScreenData {
  final NewStaffScreenOpenFrom openFrom;
  final Employee? employee;

  NewStaffScreenData({required this.openFrom, this.employee});
}

enum NewStaffScreenOpenFrom { staffItem, addNewStaffBtn }

class CreateNewStaffScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<StaffDetailScreenBloc>(
        create: (context) => StaffDetailScreenBloc(
            employeeService: context.api.employee,
            employee: context.getArguments<NewStaffScreenData>()!.employee),
        child: const CreateNewStaffScreen(),
      );

  @visibleForTesting
  const CreateNewStaffScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CreateNewStaffScreenState createState() => _CreateNewStaffScreenState();
}

class _CreateNewStaffScreenState extends KayleeState<CreateNewStaffScreen> {
  late NewStaffScreenOpenFrom openFrom;

  StaffDetailScreenBloc get bloc => context.bloc<StaffDetailScreenBloc>()!;
  late StreamSubscription staffDetailScreenBlocSub;
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();
  final homeTownCityController = PickInputController<City>();
  final addressController = KayleeFullAddressController();
  final phoneTfController = TextEditingController();
  final phoneFocus = FocusNode();
  final emailTfController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordTfController = TextEditingController();
  final passwordFocus = FocusNode();
  final roleController = PickInputController<Role>();
  final brandController = PickInputController<Brand>();
  final imagePickerController = ImagePickerController();
  final birthDayController = PickInputController<DateTime>();

  @override
  void initState() {
    super.initState();
    staffDetailScreenBlocSub = bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: () {
              popScreen();
              switch (state.error!.code) {
                case ErrorCode.nameCode:
                  return nameFocus.requestFocus();
                case ErrorCode.phoneCode:
                  return phoneFocus.requestFocus();
                case ErrorCode.passwordCode:
                  return passwordFocus.requestFocus();
              }
            },
          );
        } else if (state is NewStaffDetailModel ||
            state is DeleteStaffDetailModel ||
            state is UpdateStaffDetailModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>()!.reload(widget: StaffListScreen);
              popScreen();
            },
          );
        }
      }
    });

    final data = context.getArguments<NewStaffScreenData>()!;
    openFrom = data.openFrom;
    if (openFrom == NewStaffScreenOpenFrom.staffItem) {
      bloc.get();
    }
  }

  @override
  void dispose() {
    staffDetailScreenBlocSub.cancel();
    nameTfController.dispose();
    nameFocus.dispose();
    phoneTfController.dispose();
    phoneFocus.dispose();
    emailTfController.dispose();
    emailFocus.dispose();
    passwordTfController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == NewStaffScreenOpenFrom.staffItem
              ? Strings.chinhSuaNhanVien
              : Strings.taoNhanVienMoi,
          actionTitle: openFrom == NewStaffScreenOpenFrom.staffItem
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {
            if (openFrom == NewStaffScreenOpenFrom.staffItem) {
              showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView(
                    title: Strings.banDaChacChan,
                    content: Strings.banCoDongYLuuLaiNhungThayDoi,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: () {
                          popScreen();
                          bloc.state.item!
                            ..name = nameTfController.text
                            ..birthday = birthDayController.value.toString()
                            ..hometownCity = homeTownCityController.value
                            ..address = addressController.address
                            ..city = addressController.city
                            ..district = addressController.district
                            ..wards = addressController.ward
                            ..role = roleController.value
                            ..brand = brandController.value
                            ..phone = phoneTfController.text
                            ..email = emailTfController.text
                            ..password = passwordTfController.text
                            ..imageFile = imagePickerController.image;
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
              bloc.state.item = Employee(
                  name: nameTfController.text,
                  birthday: birthDayController.value?.toString(),
                  hometownCity: homeTownCityController.value,
                  address: addressController.address,
                  city: addressController.city,
                  district: addressController.district,
                  wards: addressController.ward,
                  role: roleController.value,
                  brand: brandController.value,
                  phone: phoneTfController.text,
                  email: emailTfController.text,
                  password: passwordTfController.text,
                  imageFile: imagePickerController.image);
              bloc.create();
            }
          },
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocConsumer<StaffDetailScreenBloc, SingleModel<Employee>>(
          listener: (context, state) {
            imagePickerController.existedImageUrl = state.item?.image;
            nameTfController.text = state.item?.name ?? '';
            birthDayController.value = state.item?.birthDayInDateTime;
            homeTownCityController.value = state.item?.hometownCity;
            addressController
              ..initAddress = state.item?.address
              ..initCity = state.item?.city
              ..initDistrict = state.item?.district
              ..initWard = state.item?.wards;
            phoneTfController.text = state.item?.phone ?? '';
            passwordTfController.text = state.item?.password ?? '';
            emailTfController.text = state.item?.email ?? '';
            roleController.value = state.item?.role;
            brandController.value = state.item?.brand;
          },
          listenWhen: (previous, current) => current is StaffDetailModel,
          buildWhen: (previous, current) => current is StaffDetailModel,
          builder: (context, state) {
            return Column(
              children: [
                KayleeImagePicker(
                  controller: imagePickerController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.hoTen,
                    hint: Strings.hoTenHint,
                    textInputAction: TextInputAction.next,
                    focusNode: nameFocus,
                    controller: nameTfController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleePickerTextField<DateTime>(
                    title: Strings.ngayThangNamSinh,
                    hint: Strings.chonNgayThangNam,
                    controller: birthDayController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleePickerTextField<City>(
                    title: Strings.queQuan,
                    hint: Strings.chonTinhTpHint,
                    controller: homeTownCityController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeFullAddressInput(
                    title: Strings.diaChiHienTai,
                    controller: addressController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.phoneInput(
                    textInputAction: TextInputAction.next,
                    controller: phoneTfController,
                    focusNode: phoneFocus,
                    nextFocusNode: passwordFocus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.password(
                    textInputAction: TextInputAction.next,
                    controller: passwordTfController,
                    focusNode: passwordFocus,
                    nextFocusNode: emailFocus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.emailTuyChon,
                    hint: Strings.emailTuyChonHint,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: emailFocus,
                    controller: emailTfController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleePickerTextField<Role>(
                    title: Strings.chucVu,
                    hint: Strings.chucVuTaiNoiLamViec,
                    controller: roleController,
                  ),
                ),
                KayleePickerTextField<Brand>(
                  title: Strings.diaDiemPhucVu,
                  controller: brandController,
                ),
                if (openFrom == NewStaffScreenOpenFrom.staffItem)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Dimens.px32, bottom: Dimens.px16),
                    child: HyperLinkText(
                      text: Strings.xoaNhanVien,
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
