import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/notification_button.dart';
import 'package:kaylee/screens/src/notification/list/bloc/notification_screen_bloc.dart';
import 'package:kaylee/screens/src/notification/list/notify_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotificationScreenBloc(
              notificationService: context.api.notification,
            ),
          ),
          BlocProvider(
            create: (context) => NotificationListBloc(
              notificationService: context.api.notification,
            ),
          ),
        ],
        child: const NotificationScreen(),
      );

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends KayleeState<NotificationScreen> {
  NotificationListBloc get _notificationListBloc =>
      context.bloc<NotificationListBloc>()!;

  NotificationScreenBloc get _notificationScreenBloc =>
      context.bloc<NotificationScreenBloc>()!;
  final searchController = SearchInputFieldController();

  @override
  void initState() {
    super.initState();
    _notificationListBloc.loadInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == NotificationScreen) {
      _notificationListBloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationListBloc, LoadMoreModel<models.Notification>>(
          listener: (context, state) {
            if (!state.loading) {
              if (state.error != null) {
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
                        .bloc<ReloadBloc>()!
                        .reload(widget: NotificationButton);
                  },
                );
              } else if (state is DeleteState) {
                _notificationListBloc.removeItem(notification: state.item!);
                showKayleeAlertMessageYesDialog(
                  context: context,
                  message: state.message,
                  onPressed: popScreen,
                  onDismiss: () {
                    context
                        .bloc<ReloadBloc>()!
                        .reload(widget: NotificationButton);
                  },
                );
              } else if (state.error != null) {
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
                margin: const EdgeInsets.only(right: Dimens.px16),
                alignment: Alignment.centerRight,
                child: HyperLinkText(
                  text: Strings.xoaTatCa,
                  textStyle: TextStyles.hyper16W500,
                  onTap: () {
                    showKayleeAlertDialog(
                        context: context,
                        view: KayleeAlertDialogView.message(
                          message: Message(
                            content: Strings.banChanChanMuonXoaTatCaThongBao,
                          ),
                          actions: [
                            KayleeAlertDialogAction.dongY(
                              isDefaultAction: true,
                              onPressed: () {
                                popScreen();
                                _notificationScreenBloc.deleteAll();
                              },
                            ),
                            KayleeAlertDialogAction.huy(
                              onPressed: popScreen,
                            ),
                          ],
                        ));
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
                            final item = state.items!.elementAt(index);
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
                              child: const KayleeLoadingIndicator(),
                            );
                          },
                          separatorBuilder: (c, index) {
                            return Container(
                              height: Dimens.px1,
                              color: ColorsRes.textFieldBorder,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: Dimens.px16),
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
        resultBundle.args is models.Notification) {
      _notificationListBloc.removeItem(notification: resultBundle.args);
      context.bloc<ReloadBloc>()!.reload(widget: NotificationButton);
    }
  }
}
