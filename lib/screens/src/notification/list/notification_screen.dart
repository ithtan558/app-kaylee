import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/notification_button.dart';
import 'package:kaylee/screens/src/notification/list/bloc/notification_screen_bloc.dart';
import 'package:kaylee/screens/src/notification/list/notify_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotificationScreenBloc(
              notificationService: context.network.provideNotificationService(),
            ),
          ),
          BlocProvider(
            create: (context) => NotificationListBloc(
              notificationService: context.network.provideNotificationService(),
            ),
          ),
        ],
        child: NotificationScreen._(),
      );

  NotificationScreen._();

  @override
  _NotificationScreenState createState() => new _NotificationScreenState();
}

class _NotificationScreenState extends KayleeState<NotificationScreen> {
  NotificationListBloc _notificationListBloc;
  NotificationScreenBloc _notificationScreenBloc;
  final searchController = SearchInputFieldController();

  @override
  void initState() {
    super.initState();
    _notificationListBloc = context.bloc<NotificationListBloc>();
    _notificationScreenBloc = context.bloc<NotificationScreenBloc>();
    _notificationListBloc.loadInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationListBloc, LoadMoreModel<models.Notification>>(
          listener: (context, state) {
            if (!state.loading) {
              if (state.code.isNotNull &&
                  state.code != ErrorType.UNAUTHORIZED) {
                showKayleeAlertErrorYesDialog(
                  context: context,
                  error: state.error,
                  onPressed: popScreen,
                );
              }
            }
          },
        ),
        BlocListener<NotificationScreenBloc, SingleModel>(
          listener: (context, state) {
            if (!state.loading) {
              hideLoading();
              if (state is DeleteAllState) {
                _notificationListBloc.removeAll();
                showKayleeAlertMessageYesDialog(
                  context: context,
                  message: state.message,
                  onPressed: popScreen,
                  onDismiss: () {
                    context
                        .bloc<ReloadBloc>()
                        .reload(widget: NotificationButton);
                  },
                );
              } else if (state is DeleteState) {
                _notificationListBloc.removeItem(notification: state.item);
                showKayleeAlertMessageYesDialog(
                  context: context,
                  message: state.message,
                  onPressed: popScreen,
                  onDismiss: () {
                    context
                        .bloc<ReloadBloc>()
                        .reload(widget: NotificationButton);
                  },
                );
              } else if (state.code.isNotNull &&
                  state.code != ErrorType.UNAUTHORIZED) {
                showKayleeAlertErrorYesDialog(
                  context: context,
                  error: state.error,
                  onPressed: popScreen,
                );
              }
            } else if (state.loading) {
              showLoading();
            }
          },
        ),
      ],
      child: UnFocusWidget(
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
                  onTap: () {
                    _notificationScreenBloc.deleteAll();
                  },
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.px16),
                color: context.theme.scaffoldBackgroundColor,
                child: KayleeTextField.search(
                  hint: Strings.timThongBaoTheoTuKhoa,
                  controller: searchController,
                  onDoneTyping: (keyword) {
                    _notificationListBloc.search(keyword: keyword);
                  },
                  onClear: _notificationListBloc.search,
                ),
              ),
              Expanded(
                child: KayleeRefreshIndicator(
                  controller: _notificationListBloc,
                  child: KayleeLoadMoreHandler(
                    controller: _notificationListBloc,
                    child: BlocBuilder<NotificationListBloc,
                        LoadMoreModel<models.Notification>>(
                      builder: (context, state) {
                        return KayleeListView(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final item = state.items.elementAt(index);
                            return NotifyItem(
                              notification: item,
                              onDeleted: () {
                                _notificationScreenBloc.delete(
                                    notification: item);
                              },
                            );
                          },
                          itemCount: state.items?.length ?? 0,
                          loadingBuilder: (context) {
                            if (state.ended) return Container();
                            return Container(
                              padding: const EdgeInsets.only(top: Dimens.px16),
                              child: CupertinoActivityIndicator(
                                radius: Dimens.px16,
                              ),
                            );
                          },
                          separatorBuilder: (c, index) {
                            return Container(
                              height: Dimens.px1,
                              color: ColorsRes.textFieldBorder,
                              margin:
                                  EdgeInsets.symmetric(horizontal: Dimens.px16),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onPopResult(Type returnScreen, Bundle resultBundle) {
    if (returnScreen == NotifyDetailScreen &&
        resultBundle?.args is models.Notification) {
      _notificationListBloc.removeItem(notification: resultBundle.args);
      context.bloc<ReloadBloc>().reload(widget: NotificationButton);
    }
  }
}
