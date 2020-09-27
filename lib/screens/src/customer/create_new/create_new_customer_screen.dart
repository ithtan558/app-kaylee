import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/customer/create_new/bloc/customer_detail_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

enum CustomerScreenOpenFrom { customerListItem, cashier, addNewCustomerBtn }

class NewCustomerScreenData {
  CustomerScreenOpenFrom openFrom;
  Customer customer;

  NewCustomerScreenData({this.openFrom, this.customer});
}

class CreateNewCustomerScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<CustomerDetailScreenBloc>(
        create: (context) => CustomerDetailScreenBloc(
            customerService: context.network.provideCustomerService(),
            customer: context.getArguments<NewCustomerScreenData>()?.customer),
        child: CreateNewCustomerScreen._(),
      );

  CreateNewCustomerScreen._();

  @override
  _CreateNewCustomerScreenState createState() =>
      _CreateNewCustomerScreenState();
}

class _CreateNewCustomerScreenState
    extends KayleeState<CreateNewCustomerScreen> {
  CustomerScreenOpenFrom openFrom;
  CustomerDetailScreenBloc bloc;
  StreamSubscription customerDetailScreenBlocSub;
  final firstNameTfController = TextEditingController();
  final firstNameFocus = FocusNode();
  final lastNameTfController = TextEditingController();
  final lastNameFocus = FocusNode();
  final homeTownCityController = PickInputController<City>();
  final addressController = KayleeFullAddressController();
  final phoneTfController = TextEditingController();
  final phoneFocus = FocusNode();
  final emailTfController = TextEditingController();
  final emailFocus = FocusNode();
  final imagePickerController = ImagePickerController();
  final birthDayController = PickInputController<DateTime>();

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<CustomerDetailScreenBloc>();
    customerDetailScreenBlocSub = bloc.listen((state) {
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
                case ErrorCode.FIRST_NAME_CODE:
                  firstNameFocus.requestFocus();
                  break;
                case ErrorCode.LAST_NAME_CODE:
                  lastNameFocus.requestFocus();
                  break;
                case ErrorCode.PHONE_CODE:
                  phoneFocus.requestFocus();
                  break;
              }
            },
          );
        } else if (state is NewCustomerDetailModel ||
            state is DeleteCustomerDetailModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>().reload(widget: CustomerListScreen);
              popScreen();
            },
          );
        } else if (state is UpdateCustomerDetailModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>().reload(widget: CustomerListScreen);
            },
          );
        }
      }
    });
    final data = context.bundle.args as NewCustomerScreenData;
    openFrom = data?.openFrom;
    if (openFrom == CustomerScreenOpenFrom.customerListItem) {
      bloc.get();
    }
  }

  @override
  void dispose() {
    customerDetailScreenBlocSub.cancel();
    firstNameTfController.dispose();
    firstNameFocus.dispose();
    lastNameTfController.dispose();
    lastNameFocus.dispose();
    phoneTfController.dispose();
    phoneFocus.dispose();
    emailTfController.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == CustomerScreenOpenFrom.customerListItem
              ? Strings.chinhSuaThongTinKhachHang
              : Strings.taoKhachHangMoi,
          actionTitle: openFrom == CustomerScreenOpenFrom.customerListItem
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {
            if (openFrom == CustomerScreenOpenFrom.customerListItem) {
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
                            ..birthday = birthDayController.value
                            ..hometownCity = homeTownCityController.value
                            ..address = addressController.address
                            ..city = addressController.city
                            ..district = addressController.district
                            ..wards = addressController.ward
                            ..phone = phoneTfController.text
                            ..email = emailTfController.text
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
              bloc.state.item = Customer(
                  firstName: firstNameTfController.text,
                  lastName: lastNameTfController.text,
                  birthday: birthDayController.value,
                  hometownCity: homeTownCityController.value,
                  address: addressController.address,
                  city: addressController.city,
                  district: addressController.district,
                  wards: addressController.ward,
                  phone: phoneTfController.text,
                  email: emailTfController.text,
                  imageFile: imagePickerController.image);
              bloc.create();
            }
          },
        ),
        child: BlocConsumer<CustomerDetailScreenBloc, SingleModel<Customer>>(
          listener: (context, state) {
            imagePickerController.existedImageUrl = state.item?.image;
            firstNameTfController.text = state.item?.firstName;
            lastNameTfController.text = state.item?.lastName;
            birthDayController.value = state.item?.birthday;
            homeTownCityController.value = state.item?.hometownCity;
            addressController
              ..initAddress = state.item?.address
              ..initCity = state.item?.city
              ..initDistrict = state.item?.district
              ..initWard = state.item?.wards;
            phoneTfController.text = state.item?.phone;
            emailTfController.text = state.item?.email;
          },
          listenWhen: (previous, current) => current is CustomerDetailModel,
          buildWhen: (previous, current) => current is CustomerDetailModel,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                  child: KayleeImagePicker(
                    controller: imagePickerController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: Row(
                    children: [
                      Expanded(
                        child: KayleeTextField.normal(
                          title: Strings.ho,
                          hint: Strings.hoHint,
                          textInputAction: TextInputAction.next,
                          focusNode: lastNameFocus,
                          controller: lastNameTfController,
                          nextFocusNode: firstNameFocus,
                        ),
                      ),
                      SizedBox(width: Dimens.px8),
                      Expanded(
                        child: KayleeTextField.normal(
                          title: Strings.ten,
                          hint: Strings.tenHint,
                          textInputAction: TextInputAction.done,
                          focusNode: firstNameFocus,
                          controller: firstNameTfController,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleePickerTextField<DateTime>(
                    title: Strings.ngayThangNamSinh,
                    hint: Strings.chonNgayThangNam,
                    controller: birthDayController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleePickerTextField<City>(
                    title: Strings.queQuan,
                    hint: Strings.chonTinhTpHint,
                    controller: homeTownCityController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleeFullAddressInput(
                    title: Strings.diaChiHienTai,
                    controller: addressController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleeTextField.phoneInput(
                    textInputAction: TextInputAction.next,
                    controller: phoneTfController,
                    focusNode: phoneFocus,
                    nextFocusNode: emailFocus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.emailTuyChon,
                    hint: Strings.emailTuyChonHint,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    controller: emailTfController,
                    focusNode: emailFocus,
                  ),
                ),
                if (openFrom == CustomerScreenOpenFrom.cashier)
                  KayLeeRoundedButton.normal(
                    text: Strings.taoDonHang,
                    onPressed: () {},
                    margin: const EdgeInsets.all(Dimens.px8),
                  ),
                if (openFrom == CustomerScreenOpenFrom.customerListItem)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Dimens.px16, bottom: Dimens.px32),
                    child: HyperLinkText(
                        text: Strings.xoaKhachHang,
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
                        }),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
