
import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';

class UserName extends StatefulWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends BaseState<UserName> {

  UserInfo? get userInfo => context.user.getUserInfo().userInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = Container(
      color: Colors.transparent,
      child: KayleeText.normalWhite16W500('Hi, ${userInfo?.name}'),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: Dimens.px56),
          child: userName,
        ),
        Padding(
          padding: const EdgeInsets.only(top: Dimens.px8),
          child: KayleeText.normalWhite12W400(Strings.quanlyCuaHang),
        ),
      ],
    );
  }
}
