import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/about/about_screen.dart';
import 'package:kaylee/screens/src/edit_profile/edit_profile_screen.dart';
import 'package:kaylee/screens/src/guide/guide_screen.dart';
import 'package:kaylee/screens/src/notification/notification_screen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimens.px10),
                boxShadow: [
                  BoxShadow(
                      color: ColorsRes.shadow,
                      offset: Offset(0, 1),
                      blurRadius: 5,
                      spreadRadius: 0)
                ],
              ),
              child: SafeArea(
                  top: true,
                  child: Container(
                    padding: const EdgeInsets.all(Dimens.px16),
                    child: SizedBox(
                      height: Dimens.px103,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.px10),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                'https://kottke.org/plus/misc/images/ai-faces-01.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: Dimens.px16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  KayleeText.normal26W700(
                                    "David Benz",
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: Dimens.px8),
                                      child: KayleeText.normal16W400(
                                        "Chủ doanh nghiệp",
                                      ),
                                    ),
                                  ),
                                  HyperLinkText(
                                    text: Strings.suThongTin,
                                    onTap: () {
                                      pushScreen(PageIntent(
                                          context, EditProfileScreen));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            _buildMenuItem(
                title: Strings.thongBao,
                icon: Images.ic_acc_notify,
                onClick: () {
                  pushScreen(PageIntent(context, NotificationScreen));
                }),
            _buildMenuItem(
                title: Strings.huongDanSd,
                icon: Images.ic_acc_guide,
                onClick: () {
                  pushScreen(PageIntent(context, GuideScreen));
                }),
            _buildMenuItem(
                title: Strings.thongTinUngDung,
                icon: Images.ic_acc_about_app,
                onClick: () {
                  pushScreen(PageIntent(context, AboutScreen));
                }),
            _buildMenuItem(
                title: Strings.quanlyDonDh,
                icon: Images.ic_acc_orderlist,
                onClick: () {}),
            _buildMenuItem(
                title: Strings.dangXuat,
                icon: Images.ic_acc_logout,
                showBtmDivider: false,
                showEndingIcon: false,
                onClick: () {}),
          ],
        ),
      ),
    );
  }

  _buildMenuItem(
      {String title,
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
