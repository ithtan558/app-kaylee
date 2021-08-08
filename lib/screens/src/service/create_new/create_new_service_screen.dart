import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/service/create_new/bloc/service_detail_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewServiceScreenData {
  final ServiceScreenOpenFrom openFrom;
  final Service? service;

  NewServiceScreenData({required this.openFrom, this.service});
}

enum ServiceScreenOpenFrom { serviceItem, addNewServiceBtn }

class CreateNewServiceScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<ServiceDetailScreenBloc>(
        create: (context) => ServiceDetailScreenBloc(
            servService: locator.apis.provideServiceApi(),
            service: context.getArguments<NewServiceScreenData>()!.service),
        child: const CreateNewServiceScreen(),
      );

  @visibleForTesting
  const CreateNewServiceScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CreateNewServiceScreenState createState() => _CreateNewServiceScreenState();
}

class _CreateNewServiceScreenState extends KayleeState<CreateNewServiceScreen> {
  late ServiceScreenOpenFrom openFrom;

  ServiceDetailScreenBloc get bloc => context.bloc<ServiceDetailScreenBloc>()!;
  late StreamSubscription serviceDetailScreenBlocSub;
  final bannerPickerController = ImagePickerController();
  final codeTfController = TextEditingController();
  final codeFocus = FocusNode();
  final nameTfController = TextEditingController();
  final nameFocus = FocusNode();
  final brandSelectController = BrandSelectTFController();
  final priceTfController = MoneyMaskedTextController(
    thousandSeparator: '.',
    precision: 0,
    decimalSeparator: '',
  );
  final priceFocus = FocusNode();
  final descriptionTfController = TextEditingController();
  final descriptionFocus = FocusNode();
  final serviceCateController = PickInputController<ServiceCate>();
  final timeController = PickInputController<Duration>();

  @override
  void initState() {
    super.initState();
    serviceDetailScreenBlocSub = bloc.stream.listen((state) {
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
                case ErrorCode.priceCode:
                  priceFocus.requestFocus();
                  break;
                case ErrorCode.nameCode:
                  nameFocus.requestFocus();
                  break;
                case ErrorCode.codeCode:
                  codeFocus.requestFocus();
                  break;
              }
            },
          );
        } else if (state is NewServiceDetailModel ||
            state is DeleteServiceDetailModel ||
            state is UpdateServiceDetailModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>()!.reload(widget: ServiceListScreen);
              popScreen();
            },
          );
        }
      }
    });
    final data = context.getArguments<NewServiceScreenData>()!;
    openFrom = data.openFrom;
    if (openFrom == ServiceScreenOpenFrom.serviceItem) {
      bloc.get();
    }
  }

  @override
  void dispose() {
    serviceDetailScreenBlocSub.cancel();
    codeTfController.dispose();
    codeFocus.dispose();
    nameTfController.dispose();
    nameFocus.dispose();
    priceTfController.dispose();
    priceFocus.dispose();
    descriptionTfController.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == ServiceScreenOpenFrom.serviceItem
              ? Strings.chinhSuaDichVu
              : Strings.taoDichVuMoi,
          actionTitle: openFrom == ServiceScreenOpenFrom.serviceItem
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {
            if (openFrom == ServiceScreenOpenFrom.serviceItem) {
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
                            ..code = codeTfController.text
                            ..name = nameTfController.text
                            ..description = descriptionTfController.text
                            ..brands = brandSelectController.brands
                            ..time = timeController.value?.inMinutes
                            ..price = int.tryParse(
                                priceTfController.text.replaceAll('.', ''))
                            ..imageFile = bannerPickerController.image
                            ..category = serviceCateController.value;
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
              bloc
                ..state.item = Service(
                    code: codeTfController.text,
                    name: nameTfController.text,
                    description: descriptionTfController.text,
                    brands: brandSelectController.brands,
                    time: timeController.value?.inMinutes,
                    price: int.tryParse(
                        priceTfController.text.replaceAll('.', '')),
                    imageFile: bannerPickerController.image,
                    category: serviceCateController.value)
                ..create();
            }
          },
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocConsumer<ServiceDetailScreenBloc, SingleModel<Service>>(
            listenWhen: (previous, current) => current is ServiceDetailModel,
            listener: (context, state) {
              bannerPickerController.existedImageUrl = state.item?.image;
              codeTfController.text = state.item?.code ?? '';
              nameTfController.text = state.item?.name ?? '';
              brandSelectController.brands = state.item?.brands;
              timeController.value = state.item?.timeInDuration;
              priceTfController.text = state.item?.price?.toString() ?? '';
              serviceCateController.value = state.item?.category;
              descriptionTfController.text = state.item?.description ?? '';
            },
            buildWhen: (previous, current) => current is ServiceDetailModel,
            builder: (context, state) {
              return Column(
                children: [
                  KayleeImagePicker(
                    controller: bannerPickerController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                    child: KayleeTextField.normal(
                      title: Strings.maDichVu,
                      hint: Strings.nhapMaDichVu,
                      controller: codeTfController,
                      focusNode: codeFocus,
                      textInputAction: TextInputAction.next,
                      nextFocusNode: nameFocus,
                      error: state.error?.code == ErrorCode.codeCode
                          ? state.error!.message
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                    child: KayleeTextField.normal(
                      title: Strings.tenDichVu,
                      hint: Strings.nhapTenDichVu,
                      controller: nameTfController,
                      textInputAction: TextInputAction.next,
                      focusNode: nameFocus,
                      nextFocusNode: priceFocus,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                    child: BrandSelectTextField(
                      title: Strings.diaDiemSuDungDichVu,
                      controller: brandSelectController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                    child: KayleePickerTextField<Duration>(
                      title: Strings.thoiGianPhucVu,
                      controller: timeController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                    child: KayleeTextField.price(
                      title: Strings.giaTien,
                      hint: '0',
                      textInputAction: TextInputAction.next,
                      controller: priceTfController,
                      focusNode: priceFocus,
                      nextFocusNode: descriptionFocus,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                    child: KayleePickerTextField<ServiceCate>(
                      title: Strings.loaiDichVu,
                      hint: Strings.chonLoaiDichVu,
                      controller: serviceCateController,
                    ),
                  ),
                  KayleeTextField.multiLine(
                    title: Strings.moTa,
                    hint: Strings.nhapMoTaDichVu,
                    textInputAction: TextInputAction.newline,
                    fieldHeight:
                        (context.screenSize.width - Dimens.px32) / (343 / 233),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: Dimens.px16),
                    controller: descriptionTfController,
                    focusNode: descriptionFocus,
                  ),
                  if (openFrom == ServiceScreenOpenFrom.serviceItem)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: Dimens.px32, bottom: Dimens.px16),
                      child: HyperLinkText(
                        text: Strings.xoaDichVu,
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
            }),
      ),
    );
  }
}
