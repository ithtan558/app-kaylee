import 'dart:ui';

import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';

class HomeTab extends StatefulWidget {
  factory HomeTab.newInstance() = HomeTab._;

  HomeTab._();

  @override
  _HomeTabState createState() => new _HomeTabState();
}

class _HomeTabState extends BaseState<HomeTab> {
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
          child: ListView.separated(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.only(bottom: Dimens.px16),
            itemBuilder: (c, index) {
              if (index == 0) {
                return _HomeMenu();
              } else if (index == 1) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.px24, bottom: Dimens.px16),
                  child: Center(
                    child: KayleeText(Strings.dsNhaCc,
                        style: TextStyles.normalWhite18W700),
                  ),
                );
              } else {
                return _buildBrandItem();
              }
            },
            itemCount: 1 + 1 + 15,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: index >= 2 ? Dimens.px16 : 0,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBrandItem() {
    final imageRatio = 96 / 30;
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
            push(PageIntent(context, BrandProdListScreen));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
                child: Container(
                  width: (screenSize.width - Dimens.px32) * 96 / 343,
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
                  child: KayleeText("Mỹ phẩm Nhật cao cấp Shiseido",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.normal12W400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeMenu extends StatelessWidget {
  final double menuHeight = 348;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: menuHeight,
      child: Material(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(Dimens.px20),
          bottomRight: Radius.circular(Dimens.px20),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: Dimens.px10,
        color: Colors.transparent,
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
              color: Colors.black.withOpacity(0.3),
            ),
          )),
          Positioned.fill(
              top: Dimens.px56,
              bottom: Dimens.px24,
              child: Column(
                children: [
                  KayleeText("Hi, Huynh An",
                      style: TextStyles.normalWhite18W700),
                  Padding(
                    padding: EdgeInsets.only(top: Dimens.px8),
                    child: KayleeText("Quản lý cửa hàng",
                        style: TextStyles.normalWhite12W400),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.px16),
                    child: Row(
                      children: [
                        _buildMenuItem(
                          title: Strings.qlChiNhanh,
                          icon: Images.ic_store,
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          title: Strings.dsDichVu,
                          icon: Images.ic_service_list,
                          onTap: () {
                            push(PageIntent(context, ServiceListScreen));
                          },
                        ),
                        _buildMenuItem(
                          title: Strings.dsSanPham,
                          icon: Images.ic_product,
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          title: Strings.qlNhanVien,
                          icon: Images.ic_person,
                          onTap: () {
                            push(PageIntent(context, StaffListScreen));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
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
                            push(PageIntent(context, CustomerListScreen));
                          },
                        ),
                        _buildMenuItem(
                          title: Strings.dsLichHen,
                          icon: Images.ic_booking,
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          title: Strings.hoaHongNv,
                          icon: Images.ic_commission,
                          onTap: () {
                            push(PageIntent(context, CommissionListScreen));
                          },
                        ),
                        _buildMenuItem(
                          title: Strings.doanhThuBanHang,
                          icon: Images.ic_revenue,
                          onTap: () {
                            push(PageIntent(context, RevenueScreen));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
            child: _NotificationIcon(),
            right: 0,
            top: Dimens.px24,
          )
        ]),
      ),
    );
  }

  _buildMenuItem({String title, String icon, Function onTap}) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 86 / 80,
        child: Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(Dimens.px8),
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    width: Dimens.px24,
                    height: Dimens.px24,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: Dimens.px8),
                    alignment: Alignment.center,
                    child: KayleeText(title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.normalWhite12W400),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
              push(PageIntent(context, NotificationScreen));
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
                  color: ColorsRes.notifyCircle, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: KayleeText('${notifyCount > 99 ? 99 : notifyCount}',
                  style: TextStyles.normalWhite12W400),
            ),
          )
      ],
    );
  }
}
