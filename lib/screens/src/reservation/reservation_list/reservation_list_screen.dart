import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/reservation/reservation_list/bloc/bloc.dart';
import 'package:kaylee/screens/src/reservation/reservation_list/widgets/reservation_item/reservation_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ReservationListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => ReservationListBloc(
          service: context.network.provideReservationService()),
      child: ReservationListScreen._());

  ReservationListScreen._();

  @override
  _ReservationListScreenState createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends BaseState<ReservationListScreen> {
  final dateFilterController =
  KayleeDateFilterController(value: DateTime.now());

  ReservationListBloc get _bloc => context.bloc<ReservationListBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.date = dateFilterController.value;
    _bloc.loadInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.dsLichHen1,
        actions: <Widget>[
          FilterButton(
            controller: _bloc,
          ),
        ],
      ),
      body: Column(
        children: [
          KayleeDateFilter(
            controller: dateFilterController,
            onChanged: (value) {
              _bloc.loadReservationsByDate(date: dateFilterController.value);
            },
          ),
          Expanded(
              child: KayleeRefreshIndicator(
                controller: _bloc,
                child: KayleeLoadMoreHandler(
                  controller: _bloc,
                  child:
                  BlocBuilder<ReservationListBloc, LoadMoreModel<Reservation>>(
                    builder: (context, state) {
                      return KayleeListView(
                          padding: const EdgeInsets.all(Dimens.px16),
                          itemBuilder: (context, index) {
                            final item = state.items.elementAt(index);
                            return ReservationItem.newInstance(
                              reservation: item,
                            );
                          },
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: Dimens.px16),
                          loadingBuilder: (context) {
                            if (state.ended) return Container();
                            return Align(
                              alignment: Alignment.topCenter,
                              child: KayleeLoadingIndicator(),
                            );
                          },
                          itemCount: state.items?.length);
                    },
                  ),
                ),
              )),
        ],
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(screen: CreateNewReservationScreen));
        },
      ),
    );
  }
}
