import 'dart:ui';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';

class HomeTab extends StatefulWidget {
  static Widget newInstance() => HomeTab._();

  HomeTab._();

  @override
  _HomeTabState createState() => new _HomeTabState();
}

class ScrollControllerCubit extends Cubit<double> {
  ScrollControllerCubit() : super(0);

  void addOffset(double offset) => emit(offset);
}

class _HomeTabState extends BaseState<HomeTab> {
  final scrollController = ScrollController();
  ScrollControllerCubit cubit = ScrollControllerCubit();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      cubit.addOffset(scrollController.offset);
    });
  }

  @override
  void dispose() {
    cubit.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Images.bg_home,
                  ),
                  fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              CubitProvider<ScrollControllerCubit>.value(
                  value: cubit, child: _HomeMenu()),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: Dimens.px16),
                  itemBuilder: (c, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: Dimens.px24, bottom: Dimens.px16),
                        child: Center(
                          child: KayleeText.normalWhite18W700(Strings.dsNhaCc),
                        ),
                      );
                    } else {
                      return _BrandItem();
                    }
                  },
                  itemCount: 1 + 15,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: index >= 1 ? Dimens.px16 : 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeMenu extends StatefulWidget {
  _HomeMenu();

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<_HomeMenu> {
  final double menuHeight = 348;

  double namePosition = Dimens.px56;
  ScrollControllerCubit cubit;
  double offset = 0;
  final menuScrollController = ScrollController();
  double collapsePercent = 0;
  double height = 0;
  double transDistance = 0;

  @override
  void initState() {
    super.initState();
    height = menuHeight - offset;
    cubit = context.cubit<ScrollControllerCubit>();
    cubit?.listen((offset) {
      this.offset = offset;

      namePosition = collapsePercent > 0.6
          ? Dimens.px56 - Dimens.px16 * (collapsePercent - 0.6) / 0.4
          : Dimens.px56;
      height = menuHeight - offset;
      transDistance = menuHeight - collapseMenuHeight;
      collapsePercent = offset / transDistance < 1 ? offset / transDistance : 1;
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
                  height: menuItemHeight,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: menuScrollController,
                    physics: collapsePercent != 1
                        ? NeverScrollableScrollPhysics()
                        : ClampingScrollPhysics(),
                    children: [
                      _buildMenuItem(
                        title: Strings.qlChiNhanh,
                        icon: Images.ic_store,
                        onTap: () {
                          context.push(PageIntent(screen: BranchListScreen));
                        },
                      ),
                      _buildMenuItem(
                        title: Strings.dsDichVu,
                        icon: Images.ic_service_list,
                        onTap: () {
                          context.push(PageIntent(screen: ServiceListScreen));
                        },
                      ),
                      _buildMenuItem(
                        title: Strings.dsSanPham,
                        icon: Images.ic_product,
                        onTap: () {
                          context.push(PageIntent(screen: ProdListScreen));
                        },
                      ),
                      _buildMenuItem(
                        title: Strings.qlNhanVien,
                        icon: Images.ic_person,
                        onTap: () {
                          context.push(PageIntent(screen: StaffListScreen));
                        },
                      ),
                      _buildMenuItem(
                        title: Strings.dsKhachHang,
                        icon: Images.ic_user_list,
                        onTap: () {
                          context.push(PageIntent(screen: CustomerListScreen));
                        },
                      ),
                      _buildMenuItem(
                        title: Strings.dsLichHen,
                        icon: Images.ic_booking,
                        onTap: () {
                          context
                              .push(PageIntent(screen: ReservationListScreen));
                        },
                      ),
                      _buildMenuItem(
                        title: Strings.hoaHongNv,
                        icon: Images.ic_commission,
                        onTap: () {
                          context
                              .push(PageIntent(screen: CommissionListScreen));
                        },
                      ),
                      _buildMenuItem(
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
          top: Dimens.px56 + Dimens.px32 + menuItemHeight,
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
                            _buildMenuItem(
                              title: Strings.dsKhachHang,
                              icon: Images.ic_user_list,
                              onTap: () {
                                context.push(
                                    PageIntent(screen: CustomerListScreen));
                              },
                            ),
                            _buildMenuItem(
                              title: Strings.dsLichHen,
                              icon: Images.ic_booking,
                              onTap: () {
                                context.push(
                                    PageIntent(screen: ReservationListScreen));
                              },
                            ),
                            _buildMenuItem(
                              title: Strings.hoaHongNv,
                              icon: Images.ic_commission,
                              onTap: () {
                                context.push(
                                    PageIntent(screen: CommissionListScreen));
                              },
                            ),
                            _buildMenuItem(
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
      Positioned(
          top: namePosition,
          left: 0,
          right: 0,
          child: Column(
            children: [
              KayleeText.normalWhite16W500("Hi, Huynh An"),
              Padding(
                padding: EdgeInsets.only(top: Dimens.px8),
                child: Opacity(
                  opacity: 1 - (Dimens.px56 - namePosition) / Dimens.px16,
                  child: KayleeText.normalWhite12W400(
                    "Quản lý cửa hàng",
                  ),
                ),
              ),
            ],
          )),
      Positioned(
        child: _NotificationIcon(),
        right: 0,
        top: Dimens.px24,
      )
    ]);
  }

  _buildMenuItem({String title, String icon, Function onTap}) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(Dimens.px8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: menuItemWith,
          height: menuItemHeight,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  icon,
                  width: context.scaleWidth(Dimens.px24),
                  height: context.scaleWidth(Dimens.px24),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    textScaleFactor: context.screenWidthRatio,
                    style: TextStyles.normalWhite12W400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double get menuItemWith => (context.screenSize.width - Dimens.px16 * 2) / 4;

  double get menuItemRatio => 86 / 80;

  double get menuItemHeight => menuItemWith / menuItemRatio;

  double get collapseMenuHeight =>
      Dimens.px56 + Dimens.px16 * 2 + Dimens.px16 + menuItemHeight;
}

class _NotificationIcon extends StatefulWidget {
  @override
  __NotificationIconState createState() => __NotificationIconState();
}

class __NotificationIconState extends State<_NotificationIcon> {
  int notifyCount = 99;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          child: FlatButton(
            onPressed: () {
              context.push(PageIntent(screen: NotificationScreen));
            },
            shape: CircleBorder(),
            child: Image.asset(
              Images.ic_notification,
              width: Dimens.px24,
              height: Dimens.px24,
            ),
          ),
        ),
        if (notifyCount > 0)
          Positioned(
            right: Dimens.px12,
            top: Dimens.px8,
            child: Container(
              width: Dimens.px17,
              height: Dimens.px17,
              decoration: BoxDecoration(
                  color: ColorsRes.errorBorder, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: KayleeText.normalWhite12W400(
                '${notifyCount > 99 ? 99 : notifyCount}',
              ),
            ),
          )
      ],
    );
  }
}

class _BrandItem extends StatelessWidget {
  final imageRatio = 96 / 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimens.px46,
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(Dimens.px5),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            context.push(PageIntent(screen: BrandProdListScreen));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
                child: Container(
                  width: (context.screenSize.width - Dimens.px32) * 96 / 343,
                  child: AspectRatio(
                      aspectRatio: imageRatio,
                      child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Shiseido_logo.svg/1280px-Shiseido_logo.svg.png')),
                ),
              ),
              Container(
                  width: 1,
                  height: Dimens.px16,
                  decoration: BoxDecoration(color: ColorsRes.textFieldBorder)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                  child: KayleeText.normal12W400(
                      "Mỹ phẩm Nhật cao cấp Shiseido",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
