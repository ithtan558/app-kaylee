import 'dart:async';

import 'package:anth_package/anth_package.dart' hide Notification;
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/special_event/hot/detail/detail/bloc/bloc.dart';
import 'package:kaylee/utils/deeplink_helper.dart';
import 'package:kaylee/widgets/widgets.dart';

class HotEventDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<HotEventDetailScreenBloc>(
        create: (context) => HotEventDetailScreenBloc(
          advertiseRepository: context.repositories.advertise,
          content: context.getArguments<Content>()!,
        ),
        child: const HotEventDetailScreen(),
      );

  const HotEventDetailScreen({Key? key}) : super(key: key);

  @override
  _HotEventDetailScreenState createState() => _HotEventDetailScreenState();
}

class _HotEventDetailScreenState extends KayleeState<HotEventDetailScreen> {
  HotEventDetailScreenBloc get _bloc =>
      context.bloc<HotEventDetailScreenBloc>()!;
  late final StreamSubscription sub;

  @override
  void initState() {
    super.initState();
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
    return BlocListener<HotEventDetailScreenBloc, SingleModel>(
      listener: (context, state) {
        if (!state.loading) {
          if (state.error != null) {
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
            onPressed: popScreen,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.px16),
          child: BlocBuilder<HotEventDetailScreenBloc, SingleModel>(
            buildWhen: (previous, current) => current is HotEventDetailModel,
            builder: (context, state) {
              if (state is! HotEventDetailModel) return Container();
              final data = state.item!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: KayleeText.normal16W500(
                      data.name,
                    ),
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                  ),
                  if (data.image.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.px16),
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        color: ColorsRes.transparent,
                        borderRadius: BorderRadius.circular(Dimens.px5),
                        child: AspectRatio(
                            aspectRatio: 343 / 128,
                            child: KayleeNetworkImage.normal(data.image)),
                      ),
                    ),
                  KayleeHtmlWidget(
                    html: data.content,
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
                      return true;
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
}
