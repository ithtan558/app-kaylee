import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class NotificationButton extends StatefulWidget {
  static Widget newInstance() => CubitProvider<NotiButtonBloc>(
        create: (context) => NotiButtonBloc(
            service: context
                .repository<NetworkModule>()
                .provideNotificationService()),
        child: NotificationButton._(),
      );

  NotificationButton._();

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  void initState() {
    super.initState();
    context.cubit<NotiButtonBloc>().getNotificationCount();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          child: FlatButton(
            onPressed: () {
              context.push(PageIntent(screen: NotificationScreen));
            },
            shape: CircleBorder(),
            child: Image.asset(
              Images.ic_notification,
              width: Dimens.px24,
              height: Dimens.px24,
            ),
          ),
        ),
        Positioned(
          right: Dimens.px12,
          top: Dimens.px8,
          child: CubitBuilder<NotiButtonBloc, int>(builder: (context, state) {
            return state <= 0
                ? Container()
                : Container(
                width: Dimens.px17,
                height: Dimens.px17,
                decoration: BoxDecoration(
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
