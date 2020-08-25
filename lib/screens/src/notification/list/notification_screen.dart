import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/notification/list/bloc/notification_screen_bloc.dart';
import 'package:kaylee/screens/src/notification/list/notify_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  static Widget newInstance() => NotificationScreen._();

  NotificationScreen._();

  @override
  _NotificationScreenState createState() => new _NotificationScreenState();
}

class _NotificationScreenState extends BaseState<NotificationScreen> {
  NotificationScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<NotificationScreenBloc>();
    _bloc.loadNotification();
  }

  @override
  void dispose() {
    super.dispose();
  }


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
              color: context.theme.scaffoldBackgroundColor,
              child: SearchInputField(hint: Strings.timThongBaoTheoTuKhoa),
            ),
            Expanded(
              child: KayleeLoadMoreHandler(
                controller: _bloc,
                child: BlocBuilder<NotificationScreenBloc,
                    LoadMoreModel<models.Notification>>(
                  builder: (context, state) {
                    return KayleeListView(
                      itemBuilder: (context, index) {
                        final item = state.items.elementAt(index);
                        return NotifyItem(
                          notification: item,
                          onTap: () {},
                          onDeleted: (item) {
                            state.items
                                .removeWhere((element) => element == item);
                            setState(() {});
                          },
                        );
                      },
                      itemCount: 10,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
