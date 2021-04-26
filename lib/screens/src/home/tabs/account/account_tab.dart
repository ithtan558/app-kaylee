import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/about/about_screen.dart';
import 'package:kaylee/screens/src/home/tabs/account/widgets/profile_widget.dart';
import 'package:kaylee/screens/src/notification/list/notification_screen.dart';
import 'package:kaylee/widgets/widgets.dart';

class AccountTab extends StatefulWidget {
  static Widget newInstance() => AccountTab._();

  AccountTab._();

  @override
  _AccountTabState createState() => new _AccountTabState();
}

class _AccountTabState extends BaseState<AccountTab> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileWidget(),
            _buildMenuItem(
                title: Strings.thongBao,
                icon: Images.ic_acc_notify,
                onClick: () {
                  pushScreen(PageIntent(screen: NotificationScreen));
                }),
            // _buildMenuItem(
            //     title: Strings.huongDanSd,
            //     icon: Images.ic_acc_guide,
            //     onClick: () {
            //       pushScreen(PageIntent(screen: GuideScreen));
            //     }),
            _buildMenuItem(
                title: Strings.thongTinUngDung,
                icon: Images.ic_acc_about_app,
                onClick: () {
                  pushScreen(PageIntent(screen: AboutScreen));
                }),
            _buildMenuItem(
                title: Strings.quanlyDonDh,
                icon: Images.ic_acc_orderlist,
                onClick: () {
                  pushScreen(PageIntent(screen: MyOrdersScreen));
                }),
            _buildMenuItem(
                title: Strings.caiDatMayIn,
                icon: Images.ic_acc_guide,
                onClick: () {
                  pushScreen(PageIntent(screen: PrinterDetailScreen));
                }),
            _buildMenuItem(
                title: Strings.giaHanUngDung,
                icon: Images.ic_acc_guide,
                onClick: () {
                  pushScreen(PageIntent(screen: ExpirationScreen));
                }),
            _buildMenuItem(
                title: Strings.dangXuat,
                icon: Images.ic_acc_logout,
                showBtmDivider: false,
                showEndingIcon: false,
                onClick: () {
                  context.bloc<AppBloc>().loggedOut();
                  context.pushToTop(PageIntent(screen: SplashScreen));
                }),
          ],
        ),
      ),
    );
  }

  _buildMenuItem({String title,
    String icon,
    bool showEndingIcon = true,
    bool showBtmDivider = true,
    Function() onClick}) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.px24, horizontal: Dimens.px16),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: Dimens.px32,
                  height: Dimens.px32,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: Dimens.px16),
                    child: KayleeText.normal16W400(
                      title,
                      maxLines: 1,
                    ),
                  ),
                ),
                if (showEndingIcon)
                  Image.asset(
                    Images.ic_right,
                    width: Dimens.px16,
                    height: Dimens.px16,
                  )
              ],
            ),
          ),
        ),
        if (showBtmDivider)
          Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              decoration: BoxDecoration(color: ColorsRes.textFieldBorder))
      ],
    );
  }
}
