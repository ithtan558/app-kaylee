import 'dart:async';

import 'package:anth_package/anth_package.dart' hide Notification;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/notification_button.dart';
import 'package:kaylee/screens/src/notification/detail/bloc/bloc.dart';
import 'package:kaylee/utils/deeplink_helper.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NotifyDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<NotifyDetailScreenBloc>(
        create: (context) => NotifyDetailScreenBloc(
          notificationService: context.network.provideNotificationService(),
          notification: context.getArguments<models.Notification>()!,
        ),
        child: const NotifyDetailScreen(),
      );

  const NotifyDetailScreen({Key? key}) : super(key: key);

  @override
  _NotifyDetailScreenState createState() => _NotifyDetailScreenState();
}

class _NotifyDetailScreenState extends KayleeState<NotifyDetailScreen>
    with NotifyDetailScreenView {
  NotifyDetailScreenBloc get _bloc => context.bloc<NotifyDetailScreenBloc>()!;
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    _bloc.view = this;
    sub = _bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
      }
    });
    _bloc.get();
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
          } else if (state.error != null) {
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
          leading: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                fixedSize:
                    MaterialStateProperty.all(const Size.square(Dimens.px44))),
            child: const Center(
              child: ImageIcon(
                AssetImage(Images.icClose),
                color: ColorsRes.hintText,
              ),
            ),
            onPressed: () {
              popScreen();
            },
          ),
          actions: <Widget>[
            Container(
              height: double.infinity,
              margin: const EdgeInsets.only(right: Dimens.px16),
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
              final data = state.item!;
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
                    onTapUrl: (url) {
                      final pageIntent =
                          DeepLinkHelper.handleNotificationLink(link: url);
                      if (pageIntent != null) {
                        pushScreen(pageIntent);
                      } else {
                        showKayleeAlertErrorYesDialog(
                            context: context,
                            error: Error(message: Strings.khongTimThayTrang),
                            onPressed: popScreen);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void updateStatusSuccess() {
    context.bloc<ReloadBloc>()!.reload(widget: NotificationButton);
  }
}

mixin NotifyDetailScreenView {
  void updateStatusSuccess() {}
}
