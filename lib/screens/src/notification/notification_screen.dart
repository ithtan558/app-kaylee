import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/notification/notify_item.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NotificationScreen extends StatefulWidget {
  factory NotificationScreen.newInstance() = NotificationScreen._;

  NotificationScreen._();

  @override
  _NotificationScreenState createState() => new _NotificationScreenState();
}

class _NotificationScreenState extends BaseState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final list = [for (int i = 1; i <= 5; i++) '$i'];

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar(
          title: Strings.thongBao,
          actions: <Widget>[
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(right: Dimens.px16),
              alignment: Alignment.centerRight,
              child: HyperLinkText(
                text: Strings.xoaTatCa,
                textStyle: TextStyles.hyper16W500,
                onTap: () {},
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(Dimens.px16),
              color: theme.scaffoldBackgroundColor,
              child: SearchInputField(hint: Strings.timThongBaoTheoTuKhoa),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return StickyHeader(
                    header: LabelDividerView.monthYear(0),
                    content: Column(
                      children: list
                          .map((e) => NotifyItem(
                                e,
                                onTap: () {
                                },
                                onDeleted: (item) {
                                  list.removeWhere(
                                      (element) => element == item);
                                  setState(() {});
                                },
                              ))
                          .toList(),
                    ),
                  );
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
