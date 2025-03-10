import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/guide/bloc/bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class GuideScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => GuideScreenBloc(
        commonService: context.api.common,
          ),
      child: const GuideScreen());

  const GuideScreen({Key? key}) : super(key: key);

  @override
  _GuideScreenState createState() => _GuideScreenState();
}

class _GuideScreenState extends KayleeState<GuideScreen> {
  GuideScreenBloc get _bloc => context.bloc<GuideScreenBloc>()!;
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _sub = _bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.error != null) {
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
      appBar: const KayleeAppBar(
        title: Strings.huongDanSd,
      ),
      padding: const EdgeInsets.all(Dimens.px16),
      child: BlocBuilder<GuideScreenBloc, SingleModel<Content>>(
        builder: (context, state) {
          return KayleeHtmlWidget(
            html: state.item?.content ?? '',
          );
        },
      ),
    );
  }
}
