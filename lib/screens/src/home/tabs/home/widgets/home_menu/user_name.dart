import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/user/user_module.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/home_menu.dart';
import 'package:kaylee/widgets/widgets.dart';

class UserName extends StatefulWidget {
  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends BaseState<UserName> {
  final positionController = BehaviorSubject<double>();
  final opacityController = BehaviorSubject<double>();
  final marginTop = Dimens.px56;
  UserInfo userinfo;

  @override
  void initState() {
    super.initState();
    positionController.add(0);
    opacityController.add(1);
    context.cubit<HomeMenuCubit>().listen((state) {
      final scrollingPercent =
          (state.collapsePercent < 0.6 ? 0 : state.collapsePercent - 0.6) / 0.4;
      final namePosition = marginTop - Dimens.px16 * scrollingPercent;

      positionController.add(namePosition);
      opacityController
          .add(1 - (marginTop - (namePosition ?? marginTop)) / Dimens.px16);
    });

    userinfo = context.repository<UserModule>().getUserInfo()?.userInfo;
  }

  @override
  void dispose() {
    opacityController.close();
    positionController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = KayleeText.normalWhite16W500("Hi, ${userinfo?.firstName}");
    final role = KayleeText.normalWhite12W400(
      "Quản lý cửa hàng",
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder<double>(
            stream: positionController.stream,
            builder: (context, snapshot) {
              final top = snapshot.data ?? marginTop;
              return Padding(
                padding: EdgeInsets.only(top: top),
                child: userName,
              );
            }),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px8),
          child: StreamBuilder<double>(
              stream: opacityController.stream,
              builder: (context, snapshot) {
                final opacity = snapshot.data ?? 1;
                return Opacity(
                  opacity: opacity,
                  child: role,
                );
              }),
        ),
      ],
    );
  }
}
