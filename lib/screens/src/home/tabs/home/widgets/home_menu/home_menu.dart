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
  ScrollControllerCubit cubit;

  final menuScrollController = ScrollController();
  HomeMenuCubit homeMenuCubit;

  @override
  void initState() {
    super.initState();
    cubit = context.cubit<ScrollControllerCubit>();
    homeMenuCubit = context.cubit<HomeMenuCubit>();
    cubit?.listen((offset) {
      homeMenuCubit.updateHomeMenuState(
          offset: offset, collapseMenuHeight: collapseMenuHeight);
      if (menuScrollController.offset > 0 &&
          homeMenuCubit.state.collapsePercent < 1) {
        menuScrollController.animateTo(0,
            duration: Duration(milliseconds: 100), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    menuScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientBg = Container(
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
    ));
    final menuRow1 = [
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
          context.push(PageIntent(screen: ReservationListScreen));
        },
      ),
      HomeMenuItem(
        title: Strings.hoaHongNv,
        icon: Images.ic_commission,
        onTap: () {
          context.push(PageIntent(screen: CommissionListScreen));
        },
      ),
      HomeMenuItem(
        title: Strings.doanhThuBanHang,
        icon: Images.ic_revenue,
        onTap: () {
          context.push(PageIntent(screen: RevenueScreen));
        },
      ),
    ];
    final menuRow2 = Column(
      children: [
        Expanded(
          child: Container(),
        ),
        Expanded(
          child: Row(
            children: [
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
                  context.push(PageIntent(screen: ReservationListScreen));
                },
              ),
              HomeMenuItem(
                title: Strings.hoaHongNv,
                icon: Images.ic_commission,
                onTap: () {
                  context.push(PageIntent(screen: CommissionListScreen));
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
        )
      ],
    );
    return Stack(children: [
      Material(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(Dimens.px20),
          bottomRight: Radius.circular(Dimens.px20),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: Dimens.px10,
        color: Colors.transparent,
        child: Stack(children: [
          CubitBuilder<HomeMenuCubit, HomeMenuState>(
            builder: (context, state) {
              return Container(height: state.height, child: gradientBg);
            },
          ),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 70, sigmaX: 100),
            child: StreamBuilder<bool>(
              stream: homeMenuCubit.backGroundStateController.stream,
              builder: (context, snapshot) {
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 250),
                  opacity: snapshot.data ?? false ? 0.6 : 0.3,
                  child: Container(
                    color: Colors.black,
                  ),
                );
              },
            ),
          ))
        ]),
      ),
      Positioned.fill(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            CubitBuilder<HomeMenuCubit, HomeMenuState>(
              builder: (context, state) => SizedBox(
                height: Dimens.px56 + Dimens.px16 * state.collapsePercent,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: Container(
                height: homeMenuItemHeight,
                child: StreamBuilder<bool>(
                    stream: homeMenuCubit.backGroundStateController.stream,
                    builder: (context, snapshot) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        controller: menuScrollController,
                        physics: !(snapshot.data ?? false)
                            ? NeverScrollableScrollPhysics()
                            : ClampingScrollPhysics(),
                        children: menuRow1,
                      );
                    }),
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
      Positioned.fill(
          top: Dimens.px56 + Dimens.px32 + homeMenuItemHeight,
          bottom: Dimens.px24,
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, top: Dimens.px16),
              child: CubitBuilder<HomeMenuCubit, HomeMenuState>(
                builder: (context, state) {
                  return Opacity(
                    opacity: state.menuRow2CollapsePercent,
                    child: Transform.scale(
                      scale: state.menuRow2CollapsePercent,
                      alignment: Alignment.centerRight,
                      child: menuRow2,
                    ),
                  );
                },
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

class HomeMenuState {
  double collapsePercent;
  double height;
  double offset;
  bool isCollapsed;
  double menuRow2CollapsePercent;

  HomeMenuState(
      {this.collapsePercent = 0,
      this.height = 0,
      this.offset = 0,
      this.isCollapsed = false,
      this.menuRow2CollapsePercent = 1});

  HomeMenuState.copy(HomeMenuState old) {
    this
      ..collapsePercent = old?.collapsePercent ?? this.collapsePercent
      ..height = old?.height ?? this.height
      ..offset = old?.offset ?? this.offset
      ..isCollapsed = old?.isCollapsed ?? this.isCollapsed
      ..menuRow2CollapsePercent =
          old?.menuRow2CollapsePercent ?? this.menuRow2CollapsePercent;
  }
}

class HomeMenuCubit extends Cubit<HomeMenuState> {
  static const double menuHeight = 348;
  final backGroundStateController = BehaviorSubject<bool>();

  HomeMenuCubit() : super(HomeMenuState(height: menuHeight)) {
    backGroundStateController?.add(false);
  }

  @override
  Future<void> close() async {
    await backGroundStateController.close();
    return super.close();
  }

  void updateHomeMenuState({double offset, double collapseMenuHeight}) {
    //offset của listview
    final offs = offset;
    //appbar chỉ collapse tới khi offset của listview = height lúc expand - height lúc collpased
    final double scrollingDistance =
        HomeMenuCubit.menuHeight - collapseMenuHeight;
    //percent collapse của appbar khi user scroll
    final double collapsePercent =
        offs < scrollingDistance ? offs / scrollingDistance : 1;
    if (collapsePercent == 1 && !state.isCollapsed) {
      //khi appbar đã collapse và state của appbar trước đó ko phải là collapse
      state.isCollapsed = true;
      backGroundStateController.add(state.isCollapsed);
    } else if (collapsePercent < 1 && state.isCollapsed) {
      //khi appbar đang scroll để expand và state của appbar trước đó là collapse
      state.isCollapsed = false;
      backGroundStateController.add(false);
    }
    emit(HomeMenuState.copy(state
      ..menuRow2CollapsePercent =
          state.collapsePercent >= 0 && state.collapsePercent < 1
              ? 1 - state.collapsePercent
              : 1
      ..collapsePercent = collapsePercent
      ..offset = offs
      ..height =
          collapsePercent == 1 ? collapseMenuHeight : menuHeight - offs));
  }
}
