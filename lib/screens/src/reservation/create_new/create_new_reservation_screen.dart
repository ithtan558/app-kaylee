import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/reservation/create_new/bloc/bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CreateNewReservationScreenData {
  final ReservationScreenOpenFrom openFrom;
  final Reservation? reservation;

  CreateNewReservationScreenData({required this.openFrom, this.reservation});
}

enum ReservationScreenOpenFrom { editButton, addNewButton }

class CreateNewReservationScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => ReservationDetailBloc(
            service: context.network.provideReservationService(),
            reservation: context
                .getArguments<CreateNewReservationScreenData>()!
                .reservation,
          ),
      child: const CreateNewReservationScreen());

  const CreateNewReservationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CreateNewReservationScreenState createState() =>
      _CreateNewReservationScreenState();
}

class _CreateNewReservationScreenState
    extends KayleeState<CreateNewReservationScreen> {
  late ReservationScreenOpenFrom openFrom;

  ReservationDetailBloc get _bloc => context.bloc<ReservationDetailBloc>()!;

  final brandController = PickInputController<Brand>();
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();
  final phoneTfController = TextEditingController();
  final phoneFocus = FocusNode();
  final addressController = KayleeFullAddressController();
  final dateController = DatePickInputController(minDate: DateTime.now());
  final timeController = PickInputController<StartTime>();
  final guessQuantityController = QuantitySliderController(quantity: 1);
  final noteTfController = TextEditingController();
  final noteFocus = FocusNode();
  late StreamSubscription reservationDetailScreenBlocSub;

  @override
  void initState() {
    super.initState();
    reservationDetailScreenBlocSub = _bloc.stream.listen((state) {
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
                case ErrorCode.phoneCode:
                  return phoneFocus.requestFocus();
                case ErrorCode.nameCode:
                  return nameFocus.requestFocus();
              }
            },
          );
        } else if (state is CancelReservationModel ||
            state is NewReservationModel ||
            state is UpdateReservationModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>()!.reload(widget: ReservationListScreen);
              popScreen();
            },
          );
        }
      }
    });
    final data = context.getArguments<CreateNewReservationScreenData>()!;
    openFrom = data.openFrom;
    if (openFrom == ReservationScreenOpenFrom.editButton) {
      _bloc.get();
    }
  }

  @override
  void dispose() {
    reservationDetailScreenBlocSub.cancel();
    noteTfController.dispose();
    noteFocus.dispose();
    phoneTfController.dispose();
    phoneFocus.dispose();
    nameTfController.dispose();
    nameFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          title: Strings.taoLichHenMoi,
          actions: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: Dimens.px16),
              child: HyperLinkText(
                text: openFrom == ReservationScreenOpenFrom.editButton
                    ? Strings.luu
                    : Strings.tao,
                onTap: () {
                  if (openFrom == ReservationScreenOpenFrom.editButton) {
                    showKayleeAlertDialog(
                        context: context,
                        view: KayleeAlertDialogView(
                          title: Strings.banDaChacChan,
                          content: Strings.banCoDongYLuuLaiNhungThayDoi,
                          actions: [
                            KayleeAlertDialogAction.dongY(
                              onPressed: () {
                                popScreen();

                                _bloc.state.item!
                                  ..name = nameTfController.text
                                  ..address = addressController.address
                                  ..city = addressController.city
                                  ..district = addressController.district
                                  ..wards = addressController.ward
                                  ..phone = phoneTfController.text
                                  ..quantity = guessQuantityController.quantity
                                  ..note = noteTfController.text
                                  ..datetime = dateController.value
                                      ?.combineWithTime(
                                          time: timeController.value?.datetime)
                                  ..brand = brandController.value;
                                _bloc.update();
                              },
                              isDefaultAction: true,
                            ),
                            KayleeAlertDialogAction.huy(
                              onPressed: popScreen,
                            ),
                          ],
                        ));
                  } else {
                    _bloc.state.item = Reservation(
                        name: nameTfController.text,
                        address: addressController.address,
                        city: addressController.city,
                        district: addressController.district,
                        wards: addressController.ward,
                        phone: phoneTfController.text,
                        quantity: guessQuantityController.quantity,
                        note: noteTfController.text,
                        datetime: dateController.value?.combineWithTime(
                            time: timeController.value?.datetime),
                        brand: brandController.value);
                    _bloc.create();
                  }
                },
              ),
            )
          ],
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocConsumer<ReservationDetailBloc, SingleModel<Reservation>>(
          listener: (context, state) {
            brandController.value = state.item?.brand;
            nameTfController.text = state.item?.name ?? '';
            addressController.initAddress = state.item?.address;
            addressController.initCity = state.item?.city;
            addressController.initDistrict = state.item?.district;
            addressController.initWard = state.item?.wards;
            phoneTfController.text = state.item?.phone ?? '';
            guessQuantityController.quantity = state.item?.quantity;
            dateController.value = state.item?.datetime;
            timeController.value = StartTime(
                time: state.item?.datetime == null
                    ? null
                    : DateFormat(dateFormat3).format(state.item!.datetime!));
            noteTfController.text = state.item?.note ?? '';
          },
          listenWhen: (previous, current) => current is DetailReservationModel,
          buildWhen: (previous, current) => current is DetailReservationModel,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleePickerTextField(
                    title: Strings.chonChiNhanh,
                    hint: Strings.chonChinhanhDeDatLich,
                    controller: brandController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.hoTen,
                    hint: Strings.hoTenHint,
                    controller: nameTfController,
                    focusNode: nameFocus,
                    nextFocusNode: phoneFocus,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                    child: KayleeTextField.phoneInput(
                      controller: phoneTfController,
                      focusNode: phoneFocus,
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeFullAddressInput(
                    title: Strings.diaChiHienTai,
                    controller: addressController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: Row(
                    children: [
                      Expanded(
                        child: KayleePickerTextField(
                          title: Strings.ngayDat,
                          hint: Strings.chonNgay,
                          controller: dateController,
                        ),
                      ),
                      const SizedBox(width: Dimens.px8),
                      Expanded(
                        child: KayleePickerTextField(
                          title: Strings.gioDat,
                          hint: Strings.chonThoiGian,
                          controller: timeController,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.px16),
                  child: KayleeQuantitySlider(
                    title: Strings.soLuongKhach,
                    controller: guessQuantityController,
                  ),
                ),
                KayleeTextField.multiLine(
                  title: Strings.ghiChu,
                  fieldHeight: 233,
                  hint: Strings.nhapGhiChuCuaKH,
                  controller: noteTfController,
                  focusNode: noteFocus,
                ),
                if (openFrom == ReservationScreenOpenFrom.editButton)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.px24,
                      bottom: Dimens.px8,
                    ),
                    child: HyperLinkText(
                      onTap: () {
                        showKayleeAlertDialog(
                            context: context,
                            view: KayleeAlertDialogView(
                              content: Strings.banDaChacChanHuyLichHenNay,
                              actions: [
                                KayleeAlertDialogAction.dongY(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    popScreen();
                                    _bloc.delete();
                                  },
                                ),
                                KayleeAlertDialogAction.huy(
                                  onPressed: popScreen,
                                ),
                              ],
                            ));
                      },
                      text: Strings.xoaHen,
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
