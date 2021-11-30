import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/bloc/order_item_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/cashier_tab.dart';
import 'package:kaylee/screens/src/home/tabs/history/history_tab.dart';

class CashierItem extends StatefulWidget {
  static Widget newInstance({required Order order}) => BlocProvider(
        key: ValueKey(order),
        create: (context) => OrderItemBloc(
          orderService: context.api.order,
          order: order,
        ),
        child: CashierItem._(order: order),
      );

  final Order order;

  const CashierItem._({required this.order});

  @override
  _CashierItemState createState() => _CashierItemState();
}

class _CashierItemState extends KayleeState<CashierItem> {
  OrderItemBloc get orderItemBloc => context.bloc<OrderItemBloc>()!;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderItemBloc, SingleModel>(
      listener: (context, state) {
        if (state.loading) {
          showLoading();
        } else if (!state.loading) {
          hideLoading();
          if (state.error != null) {
            showKayleeAlertErrorYesDialog(
                context: context, error: state.error, onPressed: popScreen);
          } else if (state.message.isNotNull) {
            showKayleeAlertMessageYesDialog(
              context: context,
              message: state.message,
              onPressed: popScreen,
              onDismiss: () {
                context.bloc<ReloadBloc>()!.reload(widget: CashierTab);
                context.bloc<ReloadBloc>()!.reload(widget: HistoryTab);
              },
            );
          }
        }
      },
      child: KayleeCartView(
        borderRadius: BorderRadius.circular(Dimens.px5),
        child: Column(
          children: [
            Container(
              height: Dimens.px40,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              color: ColorsRes.textFieldBorder,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: KayleeText.normal16W500(
                    '#${widget.order.code ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Expanded(
                    child: KayleeText.normal16W400(
                      widget.order.status == OrderStatus.notPaid
                          ? Strings.chuaThanhToan
                          : '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimens.px77,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border.fromBorderSide(BorderSide(
                      color: ColorsRes.textFieldBorder, width: Dimens.px1))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: KayleeText.normal16W500(
                        widget.order.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Expanded(
                          child: KayleePriceText.normal(
                        widget.order.amount,
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                  const SizedBox(height: Dimens.px8),
                  KayleeText.hint16W400(
                      '${Strings.gioBatDau} ${widget.order.createdAt?.toFormatString(pattern: dateFormat3)}'),
                ],
              ),
            ),
            Container(
              height: Dimens.px80,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: KayLeeRoundedButton.button2(
                      text: Strings.huy,
                      margin: EdgeInsets.zero,
                      onPressed: () {
                        showKayleeAlertDialog(
                            context: context,
                            view: KayleeAlertDialogView(
                              content: Strings.banDaChacChanHuyDonHangNay,
                              actions: [
                                KayleeAlertDialogAction.dongY(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    popScreen();
                                    orderItemBloc.cancelOrder();
                                  },
                                ),
                                KayleeAlertDialogAction.huy(
                                  onPressed: popScreen,
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                  const SizedBox(width: Dimens.px16),
                  Expanded(
                    child: KayLeeRoundedButton.normal(
                      text: Strings.chiTiet,
                      margin: EdgeInsets.zero,
                      onPressed: () {
                        context.push(PageIntent(
                          screen: CreateNewOrderScreen,
                          bundle: Bundle(NewOrderScreenData(
                              order: widget.order,
                              openFrom: OrderScreenOpenFrom.detailButton)),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
