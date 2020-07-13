import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/home_menu.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class UserName extends StatefulWidget {
  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends BaseState<UserName> {
  final positionController = BehaviorSubject<double>();

  @override
  void initState() {
    super.initState();
    context.cubit<HomeMenuCubit>().listen((state) {
      final namePosition = state.collapsePercent > 0.6
          ? Dimens.px56 - Dimens.px16 * (state.collapsePercent - 0.6) / 0.4
          : Dimens.px56;
      positionController.add(namePosition);
    });
  }

  @override
  void dispose() {
    positionController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder<double>(
            stream: positionController.stream,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(top: snapshot.data ?? Dimens.px56),
                child: KayleeText.normalWhite16W500("Hi, Huynh An"),
              );
            }),
        Padding(
          padding: EdgeInsets.only(top: Dimens.px8),
          child: StreamBuilder<double>(
              stream: positionController.stream,
              builder: (context, snapshot) {
                return Opacity(
                  opacity: 1 -
                      (Dimens.px56 - (snapshot.data ?? Dimens.px56)) /
                          Dimens.px16,
                  child: KayleeText.normalWhite12W400(
                    "Quản lý cửa hàng",
                  ),
                );
              }),
        ),
      ],
    );
  }
}
