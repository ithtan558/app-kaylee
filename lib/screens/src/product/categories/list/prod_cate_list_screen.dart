import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/product/categories/list/bloc/bloc.dart';
import 'package:kaylee/screens/src/product/categories/list/widgets/prod_cate_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProdCateListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => ProCateListScreenBloc(
            productService: context.network.provideProductService(),
          ),
      child: ProdCateListScreen._());

  ProdCateListScreen._();

  @override
  _ProdCateListScreenState createState() => _ProdCateListScreenState();
}

class _ProdCateListScreenState extends KayleeState<ProdCateListScreen> {
  ProCateListScreenBloc get _bloc => context.bloc<ProCateListScreenBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.loadInitData();
  }

  @override
  void onReloadWidget(Type screen, Bundle bundle) {
    if (screen == ProdCateListScreen) {
      _bloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.quanLyDanhMuc,
      ),
      body: Column(
        children: [
          Expanded(
            child: KayleeRefreshIndicator(
              controller: _bloc,
              child: KayleeLoadMoreHandler(
                controller: context.bloc<ProCateListScreenBloc>(),
                child: BlocConsumer<ProCateListScreenBloc,
                    LoadMoreModel<ProdCate>>(
                  listener: (context, state) {
                    if (!state.loading) {
                      if (state.code.isNotNull &&
                          state.code != ErrorType.UNAUTHORIZED) {
                        showKayleeAlertErrorYesDialog(
                          context: context,
                          error: state.error,
                          onPressed: () {
                            popScreen();
                          },
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    return KayleeListView(
                      padding: EdgeInsets.all(Dimens.px16),
                      itemBuilder: (c, index) {
                        final item = state.items.elementAt(index);
                        return ProdCateItem(
                          category: item,
                          onTap: () {
                            pushScreen(PageIntent(
                                screen: CreateNewProdCateScreen,
                                bundle: Bundle(NewProdCateScreenData(
                                  prodCate: item,
                                  openFrom: NewProdCateScreenOpenFrom.cateItem,
                                ))));
                          },
                        );
                      },
                      itemCount: state.items?.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: Dimens.px16),
                      loadingBuilder: (context) {
                        if (state.ended) return Container();
                        return Align(
                          alignment: Alignment.topCenter,
                          child: KayleeLoadingIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          KayLeeRoundedButton.normal(
            text: Strings.taoDanhMucMoi,
            onPressed: () {
              pushScreen(PageIntent(
                  screen: CreateNewProdCateScreen,
                  bundle: Bundle(NewProdCateScreenData(
                    openFrom: NewProdCateScreenOpenFrom.addNewCateBtn,
                  ))));
            },
            margin: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                .copyWith(bottom: Dimens.px16),
          )
        ],
      ),
    );
  }
}
