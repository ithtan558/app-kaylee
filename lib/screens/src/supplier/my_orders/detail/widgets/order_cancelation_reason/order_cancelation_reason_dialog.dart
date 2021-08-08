import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/supplier/my_orders/detail/widgets/order_cancelation_reason/bloc/order_cancelation_reason_bloc.dart';
import 'package:kaylee/screens/src/supplier/my_orders/detail/widgets/order_cancelation_reason/widgets/reason_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class OrderCancellationReasonDialog extends StatefulWidget {
  static Widget newInstance(
          {required ValueSetter<OrderCancellationReason> onConfirm}) =>
      BlocProvider(
        create: (context) => OrderCancellationReasonBloc(
          service: locator.apis.provideOrderApi(),
        ),
        child: OrderCancellationReasonDialog._(
          onConfirm: onConfirm,
        ),
      );
  final ValueSetter<OrderCancellationReason> onConfirm;

  const OrderCancellationReasonDialog._({required this.onConfirm});

  @override
  _OrderCancellationReasonDialogState createState() =>
      _OrderCancellationReasonDialogState();
}

class _OrderCancellationReasonDialogState
    extends KayleeState<OrderCancellationReasonDialog> {
  OrderCancellationReasonBloc get _bloc =>
      context.bloc<OrderCancellationReasonBloc>()!;

  @override
  void initState() {
    super.initState();
    _bloc.loadReasons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.px24),
          child: KayleeText.normal18W700(
            Strings.lyDoHuyDon,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          height: context.scaleHeight(204),
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal:
                  BorderSide(width: Dimens.px1, color: ColorsRes.divider),
            ),
          ),
          child: BlocBuilder<OrderCancellationReasonBloc,
              SingleModel<Map<int?, OrderCancellationReason>>>(
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: KayleeLoadingIndicator());
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  final reason = _bloc.state.item!.values.elementAt(index);
                  return ReasonItem(
                    reason: reason,
                    onSelect: () {
                      _bloc.select(selected: reason);
                    },
                  );
                },
                separatorBuilder: (context, index) => Container(
                  color: ColorsRes.divider,
                  height: Dimens.px1,
                ),
                itemCount: _bloc.state.item?.length ?? 0,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.px16),
          child: Row(
            children: [
              Expanded(
                child: KayLeeRoundedButton.button2(
                  text: Strings.huy,
                  margin: const EdgeInsets.only(right: Dimens.px8),
                  onPressed: () {
                    popScreen();
                  },
                ),
              ),
              Expanded(
                child: KayLeeRoundedButton.normal(
                  text: Strings.xacNhan,
                  margin: const EdgeInsets.only(left: Dimens.px8),
                  onPressed: () {
                    popScreen();
                    widget.onConfirm.call(_bloc.selected);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
