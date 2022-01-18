import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/special_event/daily/bloc/daily_event_screen_bloc.dart';
import 'package:kaylee/widgets/src/cart_button.dart';
import 'package:kaylee/widgets/src/kaylee_countdown.dart';
import 'package:kaylee/widgets/src/kaylee_event_product_card.dart';

class DailyEventScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<DailyEventScreenBloc>(
      create: (context) => DailyEventScreenBloc(
          advertiseRepository: context.repositories.advertise),
      child: const DailyEventScreen());

  @visibleForTesting
  const DailyEventScreen({Key? key}) : super(key: key);

  @override
  _DailyEventScreenState createState() => _DailyEventScreenState();
}

class _DailyEventScreenState extends KayleeState<DailyEventScreen> {
  DailyEventScreenBloc get _bloc => context.read<DailyEventScreenBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.giaReMoiNgay.replaceAll('\n', ' '),
        actions: const [CartButton()],
      ),
      body: BlocConsumer<DailyEventScreenBloc, LoadMoreModel<Product>>(
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
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.px8, vertical: Dimens.px16),
                child: KayleeCountdown(
                  endTime: DateTime.now().setTimeToEndOfDay(),
                ),
              ),
              Expanded(
                child: PaginationRefreshListView<Product>(
                  controller: _bloc,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, int index, item) {
                    return KayleeEventProductCard(product: item);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: Dimens.px8),
                  loadingIndicatorBuilder: (context) =>
                      const KayleeLoadingIndicator(),
                  padding: const EdgeInsets.all(Dimens.px16)
                      .copyWith(top: Dimens.px0),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
