import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/commission/detail/bloc/bloc.dart';
import 'package:kaylee/screens/src/commission/detail/widgets/commission_orders/comm_prod_order_list.dart';
import 'package:kaylee/screens/src/commission/detail/widgets/commission_orders/comm_ser_order_list.dart';
import 'package:kaylee/screens/src/commission/detail/widgets/commission_setting_dialog.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';
import 'package:kaylee/widgets/widgets.dart';

class CommissionDetailScreenData {
  Employee employee;
  DateTime date;

  CommissionDetailScreenData({this.employee, this.date});
}

class CommissionDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
        create: (context) => CommissionDetailScreenBloc(
            commissionService: context.network.provideCommissionService(),
            employee:
                context.getArguments<CommissionDetailScreenData>().employee,
            date: context.getArguments<CommissionDetailScreenData>().date),
        child: CommissionDetailScreen._(),
      );

  CommissionDetailScreen._();

  @override
  _CommissionDetailScreenState createState() => _CommissionDetailScreenState();
}

class _CommissionDetailScreenState extends KayleeState<CommissionDetailScreen> {
  CommissionDetailScreenBloc _bloc;
  StreamSubscription _sub;
  final dateController = KayleeDatePickerTextController();

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<CommissionDetailScreenBloc>();
    dateController.value = _bloc.date;
    _sub = _bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
        }
      }
    });
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
          final data = (state as CommissionDetailModel).item;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px16),
                child: KayleeText.normal16W500(
                  _bloc.employee.name,
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
                  onSelect: (value) {
                    _bloc.loadWithDate(date: value);
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
                        date: _bloc.date,
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
                        price: data.commissionProduct.total,
                      ),
                    ),
                    SizedBox(width: Dimens.px16),
                    Expanded(
                      child: KayleeTextField.priceWithUnderline(
                        title: Strings.hoaHong,
                        price: data.commissionProduct.commission,
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
                        (MediaQuery
                            .of(parentContext)
                            .padding
                            .top /
                            context.screenSize.height),
                    maxChildSize: 1 -
                        (MediaQuery
                            .of(parentContext)
                            .padding
                            .top /
                            context.screenSize.height),
                    builder: (context, scrollController) {
                      return CommSerOrderList.newInstance(
                        scrollController: scrollController,
                        date: _bloc.date,
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
                        price: data.commissionService.total,
                      ),
                    ),
                    SizedBox(width: Dimens.px16),
                    Expanded(
                      child: KayleeTextField.priceWithUnderline(
                        title: Strings.hoaHong,
                        price: data.commissionService.commission,
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
