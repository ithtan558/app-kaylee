import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/special_event/hot/list/bloc/hot_event_screen_bloc.dart';
import 'package:kaylee/screens/src/special_event/hot/list/widgets/hot_event_item.dart';
import 'package:kaylee/widgets/src/cart_button.dart';

class HotEventScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => HotEventScreenBloc(
          advertiseRepository: context.repositories.advertise),
      child: const HotEventScreen());

  @visibleForTesting
  const HotEventScreen({Key? key}) : super(key: key);

  @override
  _HotEventScreenState createState() => _HotEventScreenState();
}

class _HotEventScreenState extends KayleeState<HotEventScreen> {
  HotEventScreenBloc get _bloc => context.read<HotEventScreenBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.chuongTrinhHot.replaceAll('\n', ' '),
        actions: const [CartButton()],
      ),
      body: BlocConsumer<HotEventScreenBloc, LoadMoreModel<Content>>(
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
        builder: (context, state) {
          return PaginationRefreshListView<Content>(
            controller: _bloc,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, int index, item) {
              return HotEventItem(content: item);
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: Dimens.px8),
            loadingIndicatorBuilder: (context) =>
                const KayleeLoadingIndicator(),
            padding:
                const EdgeInsets.all(Dimens.px16).copyWith(top: Dimens.px0),
          );
        },
      ),
    );
  }
}
