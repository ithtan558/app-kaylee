import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/kaylee_appbar.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:package_info/package_info.dart';

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
      body: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform().timeout(Duration(seconds: 1)),
          builder: (context, snapshot) {
            final packageInfo = snapshot.data;
            final appName = packageInfo?.appName ?? '';
            final versionName = packageInfo?.version ?? '';
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.px16, left: Dimens.px16, right: Dimens.px16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KayleeText.normal16W500(
                        Strings.tenUngDung,
                        textAlign: TextAlign.start,
                      ),
                      KayleeText.normal16W400(
                        appName,
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
                        Strings.softwareVersion,
                        textAlign: TextAlign.start,
                      ),
                      KayleeText.normal16W400(
                        versionName,
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
