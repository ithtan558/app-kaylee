import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/special_event/salon_professional/bloc/salon_professional_screen_bloc.dart';
import 'package:kaylee/widgets/src/cart_button.dart';
import 'package:kaylee/widgets/src/kaylee_event_product_card.dart';

class SalonProfessionalScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<SalonProfessionalScreenBloc>(
      create: (context) => SalonProfessionalScreenBloc(
          advertiseRepository: context.repositories.advertise),
      child: const SalonProfessionalScreen());

  @visibleForTesting
  const SalonProfessionalScreen({Key? key}) : super(key: key);

  @override
  _SalonProfessionalScreenState createState() =>
      _SalonProfessionalScreenState();
}

class _SalonProfessionalScreenState
    extends KayleeState<SalonProfessionalScreen> {
  SalonProfessionalScreenBloc get _bloc =>
      context.read<SalonProfessionalScreenBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.salonProfessional.replaceAll('\n', ' '),
        actions: const [CartButton()],
      ),
      body: BlocConsumer<SalonProfessionalScreenBloc, LoadMoreModel<Product>>(
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
          return PaginationRefreshListView<Product>(
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
            padding:
                const EdgeInsets.all(Dimens.px16).copyWith(top: Dimens.px0),
          );
        },
      ),
    );
  }
}
