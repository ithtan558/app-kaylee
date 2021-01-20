import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/guide/bloc/bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class GuideScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => GuideScreenBloc(
            commonService: context.network.provideCommonService(),
          ),
      child: GuideScreen._());

  GuideScreen._();

  @override
  _GuideScreenState createState() => new _GuideScreenState();
}

class _GuideScreenState extends KayleeState<GuideScreen> {
  GuideScreenBloc _bloc;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<GuideScreenBloc>();
    _sub = _bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code == ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
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
    return KayleeScrollview(
      appBar: KayleeAppBar(
        title: Strings.huongDanSd,
      ),
      padding: const EdgeInsets.all(Dimens.px16),
      child: BlocBuilder<GuideScreenBloc, SingleModel<Content>>(
        builder: (context, state) {
          return HtmlWidget(
            state.item?.content ?? '',
            textStyle: TextStyles.normal16W400,
          );
        },
      ),
    );
  }
}
