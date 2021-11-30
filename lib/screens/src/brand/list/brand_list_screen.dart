import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/brand/list/bloc/brand_list_bloc.dart';
import 'package:kaylee/screens/src/brand/list/widgets/brand_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class BrandListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<BrandListBloc>(
    create: (context) => BrandListBloc(brandService: context.api.brand),
        child: const BrandListScreen(),
      );

  const BrandListScreen({Key? key}) : super(key: key);

  @override
  _BrandListScreenState createState() => _BrandListScreenState();
}

class _BrandListScreenState extends KayleeState<BrandListScreen> {
  BrandListBloc get brandListBloc => context.bloc<BrandListBloc>()!;

  @override
  void initState() {
    super.initState();
    brandListBloc.loadInitData();
  }

  @override
  void onReloadWidget(Type screen, Bundle? bundle) {
    if (screen == BrandListScreen) {
      brandListBloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.dsChiNhanh,
        actions: [
          FilterButton(
            controller: brandListBloc,
          ),
        ],
      ),
      body: BlocConsumer<BrandListBloc, LoadMoreModel<Brand>>(
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
          return PaginationRefreshListView<Brand>(
            controller: brandListBloc,
            itemBuilder: (context, int index, item) {
              return BrandItem(
                brand: item,
              );
            },
            separatorBuilder: (c, index) {
              return const SizedBox(
                height: Dimens.px16,
              );
            },
            loadingIndicatorBuilder: (context) =>
                const KayleeLoadingIndicator(),
            padding: const EdgeInsets.only(
                bottom: Dimens.px16,
                top: Dimens.px8,
                right: Dimens.px16,
                left: Dimens.px16),
          );
        },
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(
              screen: CreateNewBrandScreen,
              bundle: Bundle(NewBrandScreenData(
                  openFrom: BrandScreenOpenFrom.addNewBrandBtn))));
        },
      ),
    );
  }

  @override
  void onForceReloadingWidget() {
    brandListBloc.refresh();
  }
}
