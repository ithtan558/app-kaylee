import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/history/bloc/history_item_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/history/history_tab.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryItem extends StatefulWidget {
  static Widget newInstance({Order order}) => BlocProvider(
        key: ValueKey(order),
        create: (context) => HistoryItemBloc(
          order: order,
          orderService: context.network.provideOrderService(),
        ),
        child: HistoryItem._(
          order: order,
        ),
      );

  final Order order;

  HistoryItem._({this.order});

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends KayleeState<HistoryItem> {
  HistoryItemBloc get _bloc => context.bloc<HistoryItemBloc>();

  ReloadBloc get _reloadBloc => context.bloc<ReloadBloc>();

  @override
  Widget build(BuildContext context) {
    final date = (_bloc.order?.createdAt?.weekday ?? -1);
    return BlocListener<HistoryItemBloc, SingleModel>(
      listener: (context, state) {
        if (state.loading) {
          showLoading();
        } else if (!state.loading) {
          hideLoading();
          if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
            showKayleeAlertErrorYesDialog(
                context: context, error: state.error, onPressed: popScreen);
          } else if (state.message.isNotNull) {
            showKayleeAlertMessageYesDialog(
              context: context,
              message: state.message,
              onPressed: popScreen,
              onDismiss: () {
                _reloadBloc.reload(widget: HistoryTab);
              },
            );
          }
        }
      },
      child: KayleeCartView(
        borderRadius: BorderRadius.circular(Dimens.px5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: Dimens.px40,
              width: double.infinity,
              color: ColorsRes.textFieldBorder,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: KayleeText.normal16W500(
                      '#${_bloc.order.code ?? ''}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: KayleeText.normal16W400(
                      orderStatus2Title(status: _bloc.order.status),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimens.px16).copyWith(bottom: Dimens.px8),
              child: Row(
                children: [
                  Expanded(
                    child: KayleeText.normal16W500(
                      _bloc.order?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: KayleePriceText.normal(
                      _bloc.order?.amount ?? 0,
                      textOverflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                  .copyWith(bottom: Dimens.px16),
              child: KayleeText.hint16W400(
                '${date == DateTime.sunday ? 'CN' : 'T${date + 1}'}, ${_bloc.order?.createdAt?.toFormatString(pattern: dateFormat2)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              height: Dimens.px80,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          color: ColorsRes.textFieldBorder,
                          width: Dimens.px1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_bloc.order.status == OrderStatus.finished) ...[
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
                                      _bloc.cancelOrder();
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
                    SizedBox(width: Dimens.px16),
                  ],
                  Expanded(
                    child: KayLeeRoundedButton.normal(
                      text: Strings.chiTiet,
                      margin: EdgeInsets.zero,
                      onPressed: () {
                        context.push(PageIntent(
                            screen: HistoryOrderDetailScreen,
                            bundle: Bundle(_bloc.order)));
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
