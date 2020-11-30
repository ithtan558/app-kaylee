import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier/my_orders/detail/bloc/my_order_detail_bloc.dart';
import 'package:kaylee/screens/src/supplier/my_orders/detail/widgets/order_cancelation_reason/order_cancelation_reason_dialog.dart';
import 'package:kaylee/screens/src/supplier/my_orders/detail/widgets/order_prod_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class MyOrderDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => MyOrderDetailBloc(
            order: context.getArguments<Order>(),
            orderService: context.network.provideOrderService(),
          ),
      child: MyOrderDetailScreen._());

  MyOrderDetailScreen._();

  @override
  _MyOrderDetailScreenState createState() => _MyOrderDetailScreenState();
}

class _MyOrderDetailScreenState extends KayleeState<MyOrderDetailScreen> {
  MyOrderDetailBloc _bloc;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<MyOrderDetailBloc>();
    _sub = _bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
        } else if (state is CancelOrderModel) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>().reload(widget: MyOrdersScreen);
              popScreen();
            },
          );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar.hyperTextAction(
        title: Strings.chiTietDH,
        actionTitle: Strings.huyDon,
        onActionClick: () {
          // showKayleeAlertDialog(
          //     context: context,
          //     view: KayleeAlertDialogView(
          //       content: Strings.banDaChacChanHuyDonHangNay,
          //       actions: [
          //         KayleeAlertDialogAction.dongY(
          //           isDefaultAction: true,
          //           onPressed: () {
          //             popScreen();
          //             _bloc.cancelOrder();
          //           },
          //         ),
          //         KayleeAlertDialogAction.huy(
          //           onPressed: popScreen,
          //         ),
          //       ],
          //     ));

          showKayleeDialog(
            context: context,
            child: OrderCancellationReasonDialog.newInstance(
              onConfirm: (value) {
                _bloc.cancelOrder(
                  cancellationReason: value,
                );
              },
            ),
          );
        },
      ),
      body: BlocBuilder<MyOrderDetailBloc, SingleModel<Order>>(
        buildWhen: (previous, current) => current is OrderDetailModel,
        builder: (context, state) {
          if (state is! OrderDetailModel) return Container();
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimens.px16),
                      child: _buildInfoText(
                        icon: Images.ic_list,
                        title: '#${_bloc.order?.code ?? ''}',
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimens.px16)
                              .copyWith(top: Dimens.px16),
                      child: _buildInfoText(
                        icon: Images.ic_person,
                        title: _bloc.order?.informationReceiveName,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.px16)
                          .copyWith(top: Dimens.px8),
                      child: _buildInfoText(
                        icon: Images.ic_phone,
                        title: _bloc.order?.informationReceivePhone,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.px16)
                          .copyWith(top: Dimens.px8),
                      child: _buildInfoText(
                        icon: Images.ic_address,
                        title: _bloc.order?.informationReceiveAddress,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.px16)
                          .copyWith(top: Dimens.px8),
                      child: _buildInfoText(
                        icon: Images.ic_edit,
                        title: _bloc.order?.informationReceiveNote,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.px16)
                          .copyWith(top: Dimens.px8),
                      child: _buildInfoText(
                        icon: Images.ic_list,
                        title:
                        '${Strings.tinhTrangDonHang}: ${orderStatus2Title(
                            status: _bloc.order.status)}',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.px16)
                          .copyWith(top: Dimens.px8),
                      child: _buildInfoText(
                        icon: Images.ic_store,
                        title:
                        '${Strings.thuongHieu}: ${_bloc.order.supplierName}',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.px16)
                          .copyWith(top: Dimens.px8),
                      child: _buildInfoText(
                        icon: Images.ic_cash,
                        title: '${Strings.tienMat}',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimens.px16),
                      child: LabelDividerView.normal(title: Strings.gioHang),
                    ),
                  ],
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = state.item.orderItems.elementAt(index);
                    return OrderProdItem(
                      orderItem: item,
                    );
                  }, childCount: state.item.orderItems?.length ?? 0)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.px16),
                  child: Column(
                    children: [
                      KayleeTitlePriceText.normal(
                        title: Strings.tongChiPhi,
                        price: state.item.amount,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Dimens.px8),
                        child: KayleeTitlePriceText.bold(
                          title: Strings.thanhTien,
                          price: state.item.amount,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoText({String icon, String title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: Dimens.px8),
          child: ImageIcon(
            AssetImage(icon ?? ''),
            size: Dimens.px16,
            color: ColorsRes.hintText,
          ),
        ),
        Expanded(child: KayleeText.normal16W400(title ?? '')),
      ],
    );
  }
}
