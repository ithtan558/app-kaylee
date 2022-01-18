import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/home/bloc/scroll_offset_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/home_menu.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/supplier_list/supplier_list.dart';
import 'package:kaylee/utils/utils.dart';

class HomeTab extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
        create: (context) => ScrollOffsetBloc(),
        child: const HomeTab._(),
      );

  const HomeTab._();

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends KayleeState<HomeTab>
    with AutomaticKeepAliveClientMixin {
  ScrollOffsetBloc get scrollOffsetBloc => context.bloc<ScrollOffsetBloc>()!;

  UserInfo get userInfo => context.user.getUserInfo().userInfo!;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Images.bgHome,
                  ),
                  fit: BoxFit.fill)),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                bottom: null,
                child: BlocProvider<ScrollOffsetBloc>.value(
                    value: scrollOffsetBloc, child: HomeMenu.newInstance()),
              ),
              if (userInfo.role != UserRole.employee)
                Positioned.fill(
                  top: 120,
                  child: SupplierList.newInstance(
                    onScroll: scrollOffsetBloc.addOffset,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
