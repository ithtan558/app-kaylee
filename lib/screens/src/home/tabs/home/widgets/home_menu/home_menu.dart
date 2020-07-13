import 'dart:ui';

import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/home/home_tab.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/home_menu_item.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_item.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/user_name.dart';

class HomeMenuState {
  double collapsePercent = 0;

  HomeMenuState({this.collapsePercent = 0});

  HomeMenuState.copy(HomeMenuState old) {
    this.collapsePercent = old?.collapsePercent ?? this.collapsePercent;
  }
}

class HomeMenuCubit extends Cubit<HomeMenuState> {
  HomeMenuCubit() : super(HomeMenuState());

  void updateHomeMenuState({double collapsePercent}) =>
      emit(HomeMenuState.copy(state..collapsePercent = collapsePercent));
}

class HomeMenu extends StatefulWidget {
  static Widget newInstance() => CubitProvider<HomeMenuCubit>(
        create: (context) => HomeMenuCubit(),
        child: HomeMenu._(),
      );

  HomeMenu._();

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends BaseState<HomeMenu> {
  final double menuHeight = 348;

  double namePosition = Dimens.px56;
  ScrollControllerCubit cubit;

  double offset = 0;
  final menuScrollController = ScrollController();
  double collapsePercent = 0;
  double height = 0;
  double transDistance = 0;
  HomeMenuCubit homeMenuCubit;

  @override
  void initState() {
    super.initState();
    cubit = context.cubit<ScrollControllerCubit>();
    homeMenuCubit = context.cubit<HomeMenuCubit>();
    height = menuHeight - offset;
    cubit?.listen((offset) {
      this.offset = offset;

      height = menuHeight - offset;
      transDistance = menuHeight - collapseMenuHeight;
      collapsePercent = offset / transDistance < 1 ? offset / transDistance : 1;
      homeMenuCubit.updateHomeMenuState(collapsePercent: collapsePercent);
      if (menuScrollController.offset > 0 && collapsePercent < 1) {
        menuScrollController.animateTo(0,
            duration: Duration(milliseconds: 100), curve: Curves.linear);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    menuScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Material(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(Dimens.px20),
          bottomRight: Radius.circular(Dimens.px20),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: Dimens.px10,
        color: Colors.transparent,
        child: Container(
          height: offset <= transDistance ? height : collapseMenuHeight,
          child: Stack(children: [
            Container(
                decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsRes.color1,
                  ColorsRes.button,
                  ColorsRes.button,
                  ColorsRes.color1,
                ],
                stops: [0, 0.4, 0.7, 1],
                begin: Alignment(0.50, -0.87),
                end: Alignment(-0.50, 0.87),
                // angle: 210,
                // scale: undefined,
              ),
            )),
            Positioned.fill(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 70, sigmaX: 100),
              child: Container(
                color:
                    Colors.black.withOpacity(collapsePercent == 1 ? 0.6 : 0.3),
              ),
            ))
          ]),
        ),
      ),
      Positioned.fill(
          top: Dimens.px56 + Dimens.px16 * collapsePercent,
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.px16),
                child: Container(
                  height: homeMenuItemHeight,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: menuScrollController,
                    physics: collapsePercent != 1
                        ? NeverScrollableScrollPhysics()
                        : ClampingScrollPhysics(),
                    children: [
                      HomeMenuItem(
                        title: Strings.qlChiNhanh,
                        icon: Images.ic_store,
                        onTap: () {
                          context.push(PageIntent(screen: BranchListScreen));
                        },
                      ),
                      HomeMenuItem(
                        title: Strings.dsDichVu,
                        icon: Images.ic_service_list,
                        onTap: () {
                          context.push(PageIntent(screen: ServiceListScreen));
                        },
                      ),
                      HomeMenuItem(
                        title: Strings.dsSanPham,
                        icon: Images.ic_product,
                        onTap: () {
                          context.push(PageIntent(screen: ProdListScreen));
                        },
                      ),
                      HomeMenuItem(
                        title: Strings.qlNhanVien,
                        icon: Images.ic_person,
                        onTap: () {
                          context.push(PageIntent(screen: StaffListScreen));
                        },
                      ),
                      HomeMenuItem(
                        title: Strings.dsKhachHang,
                        icon: Images.ic_user_list,
                        onTap: () {
                          context.push(PageIntent(screen: CustomerListScreen));
                        },
                      ),
                      HomeMenuItem(
                        title: Strings.dsLichHen,
                        icon: Images.ic_booking,
                        onTap: () {
                          context
                              .push(PageIntent(screen: ReservationListScreen));
                        },
                      ),
                      HomeMenuItem(
                        title: Strings.hoaHongNv,
                        icon: Images.ic_commission,
                        onTap: () {
                          context
                              .push(PageIntent(screen: CommissionListScreen));
                        },
                      ),
                      HomeMenuItem(
                        title: Strings.doanhThuBanHang,
                        icon: Images.ic_revenue,
                        onTap: () {
                          context.push(PageIntent(screen: RevenueScreen));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container())
            ],
          )),
      Positioned.fill(
          top: Dimens.px56 + Dimens.px32 + homeMenuItemHeight,
          bottom: Dimens.px24,
          child: Container(
            alignment: Alignment.center,
            child: Opacity(
              opacity: (1 - collapsePercent) >= 0 ? 1 - collapsePercent : 0,
              child: Transform.scale(
                scale: 1 - collapsePercent >= 0 ? 1 - collapsePercent : 1,
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: Dimens.px16,
                            right: Dimens.px16,
                            top: Dimens.px16),
                        child: Row(
                          children: [
                            HomeMenuItem(
                              title: Strings.dsKhachHang,
                              icon: Images.ic_user_list,
                              onTap: () {
                                context.push(
                                    PageIntent(screen: CustomerListScreen));
                              },
                            ),
                            HomeMenuItem(
                              title: Strings.dsLichHen,
                              icon: Images.ic_booking,
                              onTap: () {
                                context.push(
                                    PageIntent(screen: ReservationListScreen));
                              },
                            ),
                            HomeMenuItem(
                              title: Strings.hoaHongNv,
                              icon: Images.ic_commission,
                              onTap: () {
                                context.push(
                                    PageIntent(screen: CommissionListScreen));
                              },
                            ),
                            HomeMenuItem(
                              title: Strings.doanhThuBanHang,
                              icon: Images.ic_revenue,
                              onTap: () {
                                context.push(PageIntent(screen: RevenueScreen));
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
      Positioned.fill(
        child: UserName(),
      ),
      Positioned(
        child: NotificationIcon(),
        right: 0,
        top: Dimens.px24,
      )
    ]);
  }

  double get homeMenuItemWith =>
      (context.screenSize.width - Dimens.px16 * 2) / 4;

  double get homeMenuItemRatio => 86 / 80;

  double get homeMenuItemHeight => homeMenuItemWith / homeMenuItemRatio;

  double get collapseMenuHeight =>
      Dimens.px56 + Dimens.px16 * 2 + Dimens.px16 + homeMenuItemHeight;
}
