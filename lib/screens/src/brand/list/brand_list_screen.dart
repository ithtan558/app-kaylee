import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/brand/list/bloc/brand_list_bloc.dart';
import 'package:kaylee/screens/src/brand/list/widgets/brand_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class BrandListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<BrandListBloc>(
        create: (context) =>
            BrandListBloc(brandService: context.network.provideBrandService()),
        child: BrandListScreen._(),
      );

  BrandListScreen._();

  @override
  _BrandListScreenState createState() => _BrandListScreenState();
}

class _BrandListScreenState extends KayleeState<BrandListScreen> {
  BrandListBloc brandListBloc;

  @override
  void initState() {
    super.initState();
    brandListBloc = context.bloc<BrandListBloc>()..loadInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReloadWidget(Type screen, Bundle bundle) {
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
      body: RefreshIndicator(
        onRefresh: () async {
          brandListBloc.refresh();
          await brandListBloc.awaitRefresh;
        },
        child: KayleeLoadMoreHandler(
          child: BlocConsumer<BrandListBloc, LoadMoreModel<Brand>>(
            listener: (context, state) {
              if (!state.loading) {
                if (state.code.isNotNull &&
                    state.code != ErrorType.UNAUTHORIZED) {
                  showKayleeAlertErrorYesDialog(
                    context: context,
                    error: state.error,
                    onPressed: popScreen,
                  );
                }
              }
            },
            builder: (context, state) {
              return KayleeListView(
                  padding: const EdgeInsets.only(
                      bottom: Dimens.px16,
                      top: Dimens.px8,
                      right: Dimens.px16,
                      left: Dimens.px16),
                  itemBuilder: (c, index) {
                    return BrandItem(
                      brand: state.items.elementAt(index),
                    );
                  },
                  separatorBuilder: (c, index) {
                    return SizedBox(
                      height: Dimens.px16,
                    );
                  },
                  loadingBuilder: (context) {
                    if (state.ended) return Container();
                    return Container(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: CupertinoActivityIndicator(
                        radius: Dimens.px16,
                      ),
                    );
                  },
                  itemCount: state.items?.length ?? 0);
            },
          ),
          controller: brandListBloc,
        ),
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
}
