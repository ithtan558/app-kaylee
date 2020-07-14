import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/reservation/reservation_list/reservation_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class ReservationListScreen extends StatefulWidget {
  static Widget newInstance() => ReservationListScreen._();

  ReservationListScreen._();

  @override
  _ReservationListScreenState createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends BaseState<ReservationListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeFilterPopUpView(
      appBar: KayleeAppBar(
        title: Strings.dsLichHen1,
        actions: <Widget>[
          KayleeAppBarAction.iconButton(
            icon: Images.ic_search,
            onTap: () {},
          )
        ],
      ),
      body: Column(
        children: [
          KayleeDateFilter(),
          Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.all(Dimens.px16),
                  itemBuilder: (context, index) {
                    return ReservationItem();
                  },
                  separatorBuilder: (context, index) =>
                      Container(height: Dimens.px16),
                  itemCount: 10)),
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
