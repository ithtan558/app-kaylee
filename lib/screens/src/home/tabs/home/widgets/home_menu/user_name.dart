import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/home_menu.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class UserName extends StatefulWidget {
  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends BaseState<UserName> {
  final positionController = BehaviorSubject<double>();
  final opacityController = BehaviorSubject<double>();
  final marginTop = Dimens.px56;
  UserInfo userInfo;
  StreamSubscription homeMenuBlocSub;
  double position;

  @override
  void initState() {
    super.initState();
    position = marginTop;
    positionController.add(position);
    opacityController.add(1);
    homeMenuBlocSub = context.bloc<HomeMenuBloc>().listen((state) {
      final scrollingPercent =
          (state.collapsePercent < 0.6 ? 0 : state.collapsePercent - 0.6) / 0.4;
      final namePosition = marginTop - Dimens.px16 * scrollingPercent;
      if (position != namePosition) {
        positionController.add(namePosition);
        opacityController
            .add(1 - (marginTop - (namePosition ?? marginTop)) / Dimens.px16);
        position = namePosition;
      }
    });

    userInfo = context.user.getUserInfo()?.userInfo;
  }

  @override
  void dispose() {
    homeMenuBlocSub.cancel();
    opacityController.close();
    positionController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = KayleeText.normalWhite16W500('Hi, ${userInfo?.firstName}');
    final role = KayleeText.normalWhite12W400(Strings.quanlyCuaHang);
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
