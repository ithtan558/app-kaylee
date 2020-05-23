import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:kaylee/widgets/src/kaylee_appbar.dart';

class AboutScreen extends StatefulWidget {
  factory AboutScreen.newInstance() = AboutScreen._;

  AboutScreen._();

  @override
  _AboutScreenState createState() => new _AboutScreenState();
}

class _AboutScreenState extends BaseState<AboutScreen> {
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
      appBar: KayleeAppBar(
        title: Strings.thongTinUngDung,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: Dimens.px16, left: Dimens.px16, right: Dimens.px16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KayleeText(
                  'Tên ứng dụng',
                  style: TextStyles.normal16W500,
                  textAlign: TextAlign.start,
                ),
                KayleeText(
                  'Kaylee',
                  style: TextStyles.normal16W400,
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KayleeText(
                  'Software Version',
                  style: TextStyles.normal16W500,
                  textAlign: TextAlign.start,
                ),
                KayleeText(
                  '12.4.5',
                  style: TextStyles.normal16W400,
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ),
          LabelDividerView.hyperLink(
            title: 'Thông tin đăng nhập',
            linkText: 'Xoá lịch sử',
            onPress: () {},
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(
                  top: Dimens.px16, left: Dimens.px24, right: Dimens.px16),
              separatorBuilder: (c, index) {
                return SizedBox(height: Dimens.px16);
              },
              itemBuilder: (c, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KayleeDateTimeText.normal(0),
                    Expanded(
                        child: KayleeText(
                      'iPhone 8',
                      textAlign: TextAlign.end,
                    )),
                  ],
                );
              },
              itemCount: 3,
            ),
          )
        ],
      ),
    );
  }
}
