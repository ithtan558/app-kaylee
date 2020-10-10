import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/reservation/reservation_list/widgets/reservation_item/bloc/bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ReservationItem extends StatefulWidget {
  static Widget newInstance({Reservation reservation}) => BlocProvider(
      key: ValueKey(reservation),
      create: (context) => ReservationItemBloc(
            service: context.network.provideReservationService(),
            reservation: reservation,
          ),
      child: ReservationItem._());

  ReservationItem._();

  @override
  _ReservationItemState createState() => _ReservationItemState();
}

class _ReservationItemState extends KayleeState<ReservationItem> {
  ReservationItemBloc get _bloc => context.bloc<ReservationItemBloc>();

  @override
  Widget build(BuildContext context) {
    return KayleeCartView(
      borderRadius: BorderRadius.circular(Dimens.px5),
      child: BlocConsumer<ReservationItemBloc, SingleModel>(
        listener: (context, state) {
          if (state.loading)
            showLoading();
          else if (!state.loading) {
            hideLoading();
            if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
              showKayleeAlertErrorYesDialog(
                  context: context, error: state.error, onPressed: popScreen);
            } else if (state.message.isNotNull) {
              showKayleeAlertMessageYesDialog(
                  context: context,
                  message: state.message,
                  onPressed: popScreen);
            }
          }
        },
        builder: (context, state) {
          final status = _bloc.reservation.status;
          return Column(
            children: [
              Container(
                height: Dimens.px40,
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                color: status == ReservationStatus.came
                    ? ColorsRes.hyper
                    : ColorsRes.textFieldBorder,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KayleeText(
                      '#${_bloc.reservation.code}',
                      style: TextStyles.normal16W500.copyWith(
                          color:
                              _bloc.reservation.status == ReservationStatus.came
                                  ? Colors.white
                                  : ColorsRes.text),
                    ),
                    _buildStatusTitle(reservation: _bloc.reservation),
                  ],
                ),
              ),
              Container(
                height: Dimens.px77,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                decoration: BoxDecoration(
                    color: status == ReservationStatus.canceled
                        ? ColorsRes.textFieldBorder
                        : Colors.white,
                    border: Border.fromBorderSide(BorderSide(
                        color: ColorsRes.textFieldBorder, width: Dimens.px1))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KayleeText.normal16W500(_bloc.reservation.customer.name),
                    SizedBox(height: Dimens.px8),
                    KayleeText.hint16W400(Strings.soLuongKhach
                        .plus(': ${_bloc.reservation.quantity ?? ''}')),
                  ],
                ),
              ),
              if (status != ReservationStatus.canceled)
                Container(
                  height: Dimens.px80,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: KayLeeRoundedButton.normal(
                          text: Strings.chinhSua,
                          margin: EdgeInsets.zero,
                          onPressed: () {
                            context.push(PageIntent(
                                screen: CreateNewReservationScreen,
                                bundle: Bundle(CreateNewReservationScreenData(
                                  openFrom:
                                      ReservationScreenOpenFrom.editButton,
                                  reservation: _bloc.reservation,
                                ))));
                          },
                        ),
                      ),
                      SizedBox(width: Dimens.px16),
                      Expanded(
                        child: status == ReservationStatus.came
                            ? KayLeeRoundedButton.normal(
                                text: Strings.taoDonHang,
                                margin: EdgeInsets.zero,
                                onPressed: () {
                                  context.push(PageIntent(
                                      screen: CreateNewOrderScreen,
                                      bundle: Bundle(NewOrderScreenData(
                                        openFrom: OrderScreenOpenFrom
                                            .addNewFromReservation,
                                        reservation: _bloc.reservation,
                                      ))));
                                },
                              )
                            : KayLeeRoundedButton.normal(
                                text: Strings.daDen,
                                margin: EdgeInsets.zero,
                                onPressed: () {
                                  _bloc.updateCameStatus();
                                },
                              ),
                      ),
                    ],
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusTitle({Reservation reservation}) {
    final status = reservation.status;
    final dateInString = reservation.datetime.isNull
        ? null
        : ' ${DateFormat(dateFormat3).format(reservation.datetime)}';
    if (status == ReservationStatus.canceled)
      return KayleeText.normal16W400(Strings.huy);
    if (status == ReservationStatus.booked)
      return KayleeText.normal16W400(Strings.daDat.plus(dateInString));
    if (status == ReservationStatus.came)
      return KayleeText.normalWhite16W400(Strings.daDen.plus(dateInString));
    return SizedBox();
  }
}
