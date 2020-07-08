import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:kaylee/widgets/src/kaylee_appbar.dart';

class AboutScreen extends StatefulWidget {
  static Widget newInstance() => AboutScreen._();

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
                KayleeText.normal16W500(
                  'Tên ứng dụng',
                  textAlign: TextAlign.start,
                ),
                KayleeText.normal16W400(
                  'Kaylee',
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
                KayleeText.normal16W500(
                  'Software Version',
                  textAlign: TextAlign.start,
                ),
                KayleeText.normal16W400(
                  '12.4.5',
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
