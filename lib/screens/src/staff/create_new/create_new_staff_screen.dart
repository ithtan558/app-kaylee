import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/staff/create_new/bloc/staff_detail_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewStaffScreenData {
  final NewStaffScreenOpenFrom openFrom;
  Employee employee;

  NewStaffScreenData({this.openFrom, this.employee});
}

enum NewStaffScreenOpenFrom { staffItem, addNewStaffBtn }

class CreateNewStaffScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<StaffDetailScreenBloc>(
        create: (context) => StaffDetailScreenBloc(
            employeeService: context.network.provideEmployeeService(),
            employee: context.getArguments<NewStaffScreenData>().employee),
        child: CreateNewStaffScreen._(),
      );

  CreateNewStaffScreen._();

  @override
  _CreateNewStaffScreenState createState() => _CreateNewStaffScreenState();
}

class _CreateNewStaffScreenState extends KayleeState<CreateNewStaffScreen> {
  NewStaffScreenOpenFrom openFrom;
  StaffDetailScreenBloc bloc;
  StreamSubscription staffDetailScreenBlocSub;
  final firstNameTfController = TextEditingController();
  final firstNameFocus = FocusNode();
  final lastNameTfController = TextEditingController();
  final lastNameFocus = FocusNode();
  final homeTownCityController = PickInputController<City>();
  final addressController = KayleeFullAddressController();
  final phoneTfController = TextEditingController();
  final phoneFocus = FocusNode();
  final roleController = PickInputController<Role>();
  final brandController = PickInputController<Brand>();
  final bannerPickerController = ImagePickerController();
  final birthDayController = PickInputController<DateTime>();

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<StaffDetailScreenBloc>();
    staffDetailScreenBlocSub = bloc.listen((state) {
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
        } else if (state.message.isNotNull) {
          showKayleeAlertMessageYesDialog(
              context: context,
              message: state.message,
              onPressed: popScreen,
              onDismiss: popScreen);
        }
      }
    });

    final data = context.getArguments<NewStaffScreenData>();
    openFrom = data?.openFrom;
    if (openFrom == NewStaffScreenOpenFrom.staffItem) {
      bloc.get();
    }
  }

  @override
  void dispose() {
    staffDetailScreenBlocSub.cancel();
    firstNameTfController.dispose();
    firstNameFocus.dispose();
    lastNameTfController.dispose();
    lastNameFocus.dispose();
    phoneTfController.dispose();
    phoneFocus.dispose();
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
                          bloc.state.item
                            ..firstName = firstNameTfController.text
                            ..lastName = lastNameTfController.text
                            ..birthday = birthDayController.value.toString()
                            ..hometownCity = homeTownCityController.value
                            ..address = addressController.address
                            ..city = addressController.city
                            ..district = addressController.district
                            ..wards = addressController.ward
                            ..role = roleController.value
                            ..brand = brandController.value
                            ..phone = phoneTfController.text
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
              bloc.state.item = Employee(
                  firstName: firstNameTfController.text,
                  lastName: lastNameTfController.text,
                  birthday: birthDayController.value?.toString(),
                  hometownCity: homeTownCityController.value,
                  address: addressController.address,
                  city: addressController.city,
                  district: addressController.district,
                  wards: addressController.ward,
                  role: roleController.value,
                  brand: brandController.value,
                  phone: phoneTfController.text,
                  imageFile: bannerPickerController.image);
              bloc.create();
            }
          },
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocBuilder<StaffDetailScreenBloc, SingleModel<Employee>>(
          buildWhen: (previous, current) => !current.loading,
          builder: (context, state) {
            bannerPickerController.existedImageUrl = state.item?.image;
            firstNameTfController.text = state.item?.firstName;
            lastNameTfController.text = state.item?.lastName;
            birthDayController.value = state.item?.birthDayInDateTime;
            homeTownCityController.value = state.item?.hometownCity;
            addressController
              ..initAddress = state.item?.address
              ..initCity = state.item?.city
              ..initDistrict = state.item?.district
              ..initWard = state.item?.wards;
            phoneTfController.text = state.item?.phone;
            roleController.value = state.item?.role;
            brandController.value = state.item?.brand;
            return Column(
              children: [
                KayleeImagePicker(
                  controller: bannerPickerController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                  child: Row(
                    children: [
                      Expanded(
                        child: KayleeTextField.normal(
                          title: Strings.ho,
                          hint: Strings.hoHint,
                          textInputAction: TextInputAction.next,
                          focusNode: lastNameFocus,
                          nextFocusNode: firstNameFocus,
                          controller: lastNameTfController,
                        ),
                      ),
                      SizedBox(width: Dimens.px8),
                      Expanded(
                        child: KayleeTextField.normal(
                            title: Strings.ten,
                            hint: Strings.tenHint,
                            textInputAction: TextInputAction.done,
                            focusNode: firstNameFocus,
                            controller: firstNameTfController),
                      ),
                    ],
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
                    key: UniqueKey(),
                    textInputAction: TextInputAction.done,
                    controller: phoneTfController,
                    focusNode: phoneFocus,
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.only(bottom: Dimens.px16),
//                  child: KayleeTextField.normal(
//                    title: Strings.emailTuyChon,
//                    hint: Strings.emailTuyChonHint,
//                    textInputType: TextInputType.emailAddress,
//                    textInputAction: TextInputAction.next,
//                  ),
//                ),
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
