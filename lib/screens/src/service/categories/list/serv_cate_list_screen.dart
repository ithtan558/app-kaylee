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
      child: const ServCateListScreen());

  @visibleForTesting
  const ServCateListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ServCateListScreenState createState() => _ServCateListScreenState();
}

class _ServCateListScreenState extends KayleeState<ServCateListScreen> {
  ServCateListScreenBloc get _bloc => context.bloc<ServCateListScreenBloc>()!;

  @override
  void initState() {
    super.initState();
    _bloc.loadInitData();
  }

  @override
  void onReloadWidget(Type screen, Bundle? bundle) {
    if (screen == ServCateListScreen) {
      _bloc.refresh();
    }
  }

  @override
  void onForceReloadingWidget() {
    _bloc.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KayleeAppBar(
        title: Strings.quanLyDanhMuc,
      ),
      body: Column(
        children: [
          Expanded(
            child: KayleeRefreshIndicator(
              controller: _bloc,
              child: KayleeLoadMoreHandler(
                controller: _bloc,
                child: BlocConsumer<ServCateListScreenBloc,
                    LoadMoreModel<ServiceCate>>(
                  listener: (context, state) {
                    if (!state.loading) {
                      if (state.error != null) {
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
                      padding: const EdgeInsets.all(Dimens.px16),
                      itemBuilder: (c, index) {
                        final item = state.items!.elementAt(index);
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
                          const SizedBox(height: Dimens.px16),
                      loadingBuilder: (context) {
                        if (state.ended) return Container();
                        return const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: Dimens.px16),
                            child: KayleeLoadingIndicator(),
                          ),
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
