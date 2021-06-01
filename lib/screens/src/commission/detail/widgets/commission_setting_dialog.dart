import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/commission/detail/bloc/commission_setting_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CommissionSettingDialog extends StatefulWidget {
  static Widget newInstance({ScrollController scrollController}) =>
      BlocProvider(
        create: (context) => CommissionSettingBloc(
          employee: context.repository<Employee>(),
          commissionService: context.network.provideCommissionService(),
        ),
        child: CommissionSettingDialog._(
          scrollController: scrollController,
        ),
      );
  final ScrollController scrollController;

  CommissionSettingDialog._({this.scrollController});

  @override
  _CommissionSettingDialogState createState() =>
      _CommissionSettingDialogState();
}

class _CommissionSettingDialogState
    extends KayleeState<CommissionSettingDialog> {
  final productController = TextEditingController();
  final serviceController = TextEditingController();
  final productFocus = FocusNode();
  final serviceFocus = FocusNode();
  CommissionSettingBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<CommissionSettingBloc>();
    _bloc.loadSetting();
  }

  @override
  void dispose() {
    productController.dispose();
    serviceController.dispose();
    productFocus.dispose();
    serviceFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child:
          BlocListener<CommissionSettingBloc, SingleModel<CommissionSetting>>(
        listener: (context, state) {
          if (state.loading ?? false) {
            showLoading();
          } else if (!(state.loading ?? false)) {
            hideLoading();
            if (state.error != null) {
              showKayleeAlertErrorYesDialog(
                  context: context, onPressed: popScreen, error: state.error);
            } else if (state is CommissionSettingUpdateModel) {
              showKayleeAlertMessageYesDialog(
                context: context,
                message: state.message,
                onPressed: popScreen,
              );
            }
          }
        },
        child: Column(
          children: [
            KayleeText.normal18W700(
              Strings.chinhSuaThongTinHoaHong,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: BlocConsumer<CommissionSettingBloc,
                  SingleModel<CommissionSetting>>(
                listener: (context, state) {
                  if (state is CommissionSettingModel) {
                    final data = state.item;
                    productController.text =
                        data?.commissionProduct?.toString();
                    serviceController.text =
                        data?.commissionService?.toString();
                  }
                },
                listenWhen: (previous, current) =>
                    current is CommissionSettingModel,
                buildWhen: (previous, current) =>
                    current is CommissionSettingModel,
                builder: (context, state) {
                  if (state is! CommissionSettingModel)
                    return Center(child: KayleeLoadingIndicator());
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimens.px16),
                    physics: BouncingScrollPhysics(),
                    controller: widget.scrollController,
                    child: Column(
                      children: [
                        KayleeTextField.withUnit(
                          title: Strings.hoaHongSanPham,
                          unit: '%',
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          controller: productController,
                          focusNode: productFocus,
                          nextFocusNode: serviceFocus,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: Dimens.px16),
                          child: KayleeTextField.withUnit(
                            title: Strings.hoaHongDichVu,
                            unit: '%',
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.number,
                            controller: serviceController,
                            focusNode: serviceFocus,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: ColorsRes.divider,
                width: Dimens.px1,
              ))),
              padding: const EdgeInsets.only(
                  left: Dimens.px8,
                  right: Dimens.px8,
                  top: Dimens.px16,
                  bottom: Dimens.px8),
              child: Row(
                children: [
                  Expanded(
                    child: KayLeeRoundedButton.button2(
                      margin: EdgeInsets.zero,
                      text: Strings.huyBo,
                      onPressed: popScreen,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayLeeRoundedButton.normal(
                      margin: EdgeInsets.zero,
                      text: Strings.luu,
                      onPressed: () {
                        primaryFocus.unfocus();
                        _bloc.updateSetting(
                          product: int.tryParse(productController.text),
                          service: int.tryParse(serviceController.text),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onForceReloadingWidget() {
    _bloc.loadSetting();
  }
}
