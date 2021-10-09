import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/bloc.dart';

class NotificationButton extends StatefulWidget {
  static Widget newInstance() => const NotificationButton._();

  const NotificationButton._();

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends KayleeState<NotificationButton> {
  NotiButtonBloc get bloc => context.bloc<NotiButtonBloc>()!;

  @override
  void initState() {
    super.initState();
    bloc.getNotificationCount();
  }

  @override
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == NotificationButton) {
      bloc.getNotificationCount();
    }
  }

  @override
  void onForceReloadingWidget() {
    bloc.getNotificationCount();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TextButton(
          onPressed: () {
            context.push(PageIntent(screen: NotificationScreen));
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              fixedSize:
                  MaterialStateProperty.all(const Size.square(Dimens.px56))),
          child: Image.asset(
            Images.icNotification,
            width: Dimens.px24,
            height: Dimens.px24,
          ),
        ),
        Positioned(
          right: Dimens.px12,
          top: Dimens.px8,
          child: BlocBuilder<NotiButtonBloc, int>(builder: (context, state) {
            return state <= 0
                ? Container()
                : Container(
                    width: Dimens.px17,
                    height: Dimens.px17,
                    decoration: const BoxDecoration(
                        color: ColorsRes.errorBorder, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: KayleeText.normalWhite12W400(
                      '${state > 99 ? 99 : state}',
                    ));
          }),
        )
      ],
    );
  }
}
