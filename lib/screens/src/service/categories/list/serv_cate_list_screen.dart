import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/service/categories/list/bloc/bloc.dart';
import 'package:kaylee/screens/src/service/categories/list/widgets/serv_cate_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ServCateListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => ServCateListScreenBloc(
            servService: context.network.provideServService(),
          ),
      child: ServCateListScreen._());

  ServCateListScreen._();

  @override
  _ServCateListScreenState createState() => _ServCateListScreenState();
}

class _ServCateListScreenState extends KayleeState<ServCateListScreen> {
  ServCateListScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<ServCateListScreenBloc>();
    _bloc.loadInitData();
  }

  @override
  void onReloadScreen(Type screen, Bundle bundle) {
    if (screen == ServCateListScreen) {
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
              child: KayleeLoadMoreHandler(
                controller: context.bloc<ServCateListScreenBloc>(),
                child: BlocConsumer<ServCateListScreenBloc,
                    LoadMoreModel<ServiceCate>>(
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
                        return ServCateItem(
                          category: item,
                          onTap: () {
                            pushScreen(PageIntent(
                                screen: CreateNewServCateScreen,
                                bundle: Bundle(NewServCateScreenData(
                                  serviceCate: item,
                                  openFrom: NewSerCateScreenOpenFrom.cateItem,
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
                  screen: CreateNewServCateScreen,
                  bundle: Bundle(NewServCateScreenData(
                    openFrom: NewSerCateScreenOpenFrom.addNewCateBtn,
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
