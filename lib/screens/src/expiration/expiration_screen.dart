import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/expiration/bloc/expiration_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ExpirationScreenArgument {
  final bool isExpired;

  ExpirationScreenArgument({this.isExpired = false});
}

class ExpirationScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => ExpirationScreenBloc(
            commonService: context.network.provideCommonService(),
            userService: context.network.provideUserService(),
          ),
      child: ExpirationScreen._());

  ExpirationScreen._();

  @override
  _ExpirationScreenState createState() => new _ExpirationScreenState();
}

class _ExpirationScreenState extends KayleeState<ExpirationScreen> {
  ExpirationScreenBloc get _bloc => context.bloc<ExpirationScreenBloc>()!;
  late StreamSubscription _sub;

  ExpirationScreenArgument get argument =>
      context.getArguments<ExpirationScreenArgument>() ??
      ExpirationScreenArgument();

  @override
  void initState() {
    super.initState();
    _sub = _bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state is CheckExpirationSuccessModel) {
          context.pop();
        } else if (state.error != null) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: context.pop);
        }
      }
    });
    _bloc.loadContent();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !argument.isExpired;
      },
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          title: Strings.giaHanSuDung,
          automaticallyImplyLeading: !argument.isExpired,
          actions: [
            if (argument.isExpired)
              KayleeAppBarAction.hyperText(
                title: Strings.dangXuat,
                onTap: context.bloc<AppBloc>()!.loggedOut,
              )
          ],
        ),
        padding: const EdgeInsets.all(Dimens.px16),
        child: BlocBuilder<ExpirationScreenBloc, SingleModel<Content>>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: HtmlWidget(
                state.item?.content ?? '',
                textStyle: TextStyles.normal16W400,
              ),
            );
          },
        ),
        bottom: argument.isExpired
            ? KayLeeRoundedButton.normal(
                text: Strings.thuLai,
                margin: const EdgeInsets.symmetric(
                    vertical: Dimens.px16, horizontal: Dimens.px16),
                onPressed: _bloc.checkExpirationAgain,
              )
            : null,
      ),
    );
  }
}
