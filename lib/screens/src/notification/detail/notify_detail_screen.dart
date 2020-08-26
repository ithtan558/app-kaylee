import 'dart:async';

import 'package:anth_package/anth_package.dart' hide Notification;
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/notification/detail/bloc/bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NotifyDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<NotifyDetailScreenBloc>(
        create: (context) => NotifyDetailScreenBloc(
          notificationService: context.network.provideNotificationService(),
          notification: context.getArguments<models.Notification>(),
        ),
        child: NotifyDetailScreen._(),
      );

  NotifyDetailScreen._();

  @override
  _NotifyDetailScreenState createState() => new _NotifyDetailScreenState();
}

class _NotifyDetailScreenState extends KayleeState<NotifyDetailScreen> {
  NotifyDetailScreenBloc _bloc;
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<NotifyDetailScreenBloc>();
    sub = _bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
      }
    });
    _bloc.loadDetail();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotifyDetailScreenBloc, SingleModel>(
      listener: (context, state) {
        if (!state.loading) {
          if (state is DeleteNotificationState) {
            showKayleeAlertMessageYesDialog(
              context: context,
              message: state.message,
              onPressed: popScreen,
              onDismiss: () {
                popScreen(resultBundle: Bundle(state.item));
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
        }
      },
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          leading: FlatButton(
            shape: CircleBorder(),
            child: ImageIcon(
              AssetImage(Images.ic_close),
              color: ColorsRes.hintText,
              size: 44,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          actions: <Widget>[
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(right: Dimens.px16),
              alignment: Alignment.centerRight,
              child: HyperLinkText(
                text: Strings.xoa,
                textStyle: TextStyles.hyper16W500,
                onTap: () {
                  _bloc.delete();
                },
              ),
            )
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.px16),
          child: BlocBuilder<NotifyDetailScreenBloc, SingleModel>(
            buildWhen: (previous, current) =>
            current is NotificationDetailModel,
            builder: (context, state) {
              if (state is! NotificationDetailModel) return Container();
              final data = (state as NotificationDetailModel).item;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: KayleeText.normal16W500(
                      data.title ?? '',
                    ),
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                  ),
                  HtmlWidget(
                    data.content ?? '',
                    textStyle: TextStyles.hint16W400,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
