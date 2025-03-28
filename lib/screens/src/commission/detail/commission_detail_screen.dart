import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/commission/detail/bloc/bloc.dart';
import 'package:kaylee/screens/src/commission/detail/widgets/commission_orders/comm_prod_order_list.dart';
import 'package:kaylee/screens/src/commission/detail/widgets/commission_orders/comm_ser_order_list.dart';
import 'package:kaylee/screens/src/commission/detail/widgets/commission_setting_dialog.dart';

class CommissionDetailScreenData {
  Employee employee;
  DateTime date;

  CommissionDetailScreenData({required this.employee, required this.date});
}

class CommissionDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
        create: (context) => CommissionDetailScreenBloc(
            commissionService: context.api.commission,
            employee:
                context.getArguments<CommissionDetailScreenData>()!.employee,
            startDate:
                context.getArguments<CommissionDetailScreenData>()!.date),
        child: const CommissionDetailScreen(),
      );

  const CommissionDetailScreen({Key? key}) : super(key: key);

  @override
  _CommissionDetailScreenState createState() => _CommissionDetailScreenState();
}

class _CommissionDetailScreenState extends KayleeState<CommissionDetailScreen> {
  CommissionDetailScreenBloc get _bloc =>
      context.bloc<CommissionDetailScreenBloc>()!;
  late StreamSubscription _sub;
  final dateController = KayleeDatePickerTextController();

  @override
  void initState() {
    super.initState();
    // dateController.value = _bloc.date;
    _sub = _bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
        }
      }
    });
    _bloc.loadDetail();
  }

  @override
  void onForceReloadingWidget() {
    _bloc.loadDetail();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext parentContext) {
    return KayleeScrollview(
      appBar: KayleeAppBar(
        title: Strings.chiTietHoaHong,
        actions: [
          KayleeAppBarAction.hyperText(
            title: Strings.caiDat,
            onTap: () {
              showKayleeBottomSheet(
                parentContext,
                initialChildSize: 330 / parentContext.screenSize.height,
                maxChildSize: 330 / parentContext.screenSize.height,
                builder: (context, scrollController) {
                  return RepositoryProvider.value(
                    value: _bloc.employee,
                    child: CommissionSettingDialog.newInstance(
                      scrollController: scrollController,
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      child: BlocBuilder<CommissionDetailScreenBloc, SingleModel>(
        buildWhen: (previous, current) => current is CommissionDetailModel,
        builder: (context, state) {
          if (state is! CommissionDetailModel) return Container();
          final data = state.item!;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px16),
                child: KayleeText.normal16W500(
                  _bloc.employee.name ?? '',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px24, bottom: Dimens.px16),
                child: KayleeTotalAmountText(
                  price: data.commissionTotal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px24),
                child: KayleeDatePickerText(
                  onSelectRange: (value) {
                    _bloc.loadWithDate(
                        startDate: value.start, endDate: value.end);
                  },
                  controller: dateController,
                ),
              ),
              LabelDividerView.withButton(
                title: Strings.hoaHongSanPham,
                buttonText: Strings.donHang,
                onPress: () {
                  showKayleeBottomSheet(
                    context,
                    initialChildSize: 1 -
                        (MediaQuery.of(parentContext).padding.top /
                            context.screenSize.height),
                    maxChildSize: 1 -
                        (MediaQuery.of(parentContext).padding.top /
                            context.screenSize.height),
                    builder: (context, scrollController) {
                      return CommProdOrderList.newInstance(
                        scrollController: scrollController,
                        range: DateTimeRange(
                            start: _bloc.startDate, end: _bloc.endDate),
                        employee: _bloc.employee,
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16,
                    left: Dimens.px16,
                    right: Dimens.px16,
                    bottom: Dimens.px24),
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeTextField.priceWithUnderline(
                        title: Strings.doanhSo,
                        price: data.commissionProduct?.total,
                      ),
                    ),
                    const SizedBox(width: Dimens.px16),
                    Expanded(
                      child: KayleeTextField.priceWithUnderline(
                        title: Strings.hoaHong,
                        price: data.commissionProduct?.commission,
                      ),
                    ),
                  ],
                ),
              ),
              LabelDividerView.withButton(
                title: Strings.hoaHongDichVu,
                buttonText: Strings.donHang,
                onPress: () {
                  showKayleeBottomSheet(
                    context,
                    initialChildSize: 1 -
                        (MediaQuery.of(parentContext).padding.top /
                            context.screenSize.height),
                    maxChildSize: 1 -
                        (MediaQuery.of(parentContext).padding.top /
                            context.screenSize.height),
                    builder: (context, scrollController) {
                      return CommSerOrderList.newInstance(
                        scrollController: scrollController,
                        range: DateTimeRange(
                            start: _bloc.startDate, end: _bloc.endDate),
                        employee: _bloc.employee,
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16,
                    left: Dimens.px16,
                    right: Dimens.px16,
                    bottom: Dimens.px24),
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeTextField.priceWithUnderline(
                        title: Strings.doanhSo,
                        price: data.commissionService?.total,
                      ),
                    ),
                    const SizedBox(width: Dimens.px16),
                    Expanded(
                      child: KayleeTextField.priceWithUnderline(
                        title: Strings.hoaHong,
                        price: data.commissionService?.commission,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
