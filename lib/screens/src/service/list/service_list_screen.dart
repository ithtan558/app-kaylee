import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/service/list/bloc/service_cate_bloc.dart';
import 'package:kaylee/screens/src/service/list/bloc/service_list_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ServiceListScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider<ServiceCateBloc>(
          create: (context) => ServiceCateBloc(
            servService: context.network.provideServService(),
          ),
        ),
        BlocProvider<ServiceListBloc>(
          create: (context) => ServiceListBloc(
            servService: context.network.provideServService(),
          ),
        ),
      ], child: ServiceListScreen._());

  ServiceListScreen._();

  @override
  _ServiceListScreenState createState() => new _ServiceListScreenState();
}

class _ServiceListScreenState extends KayleeState<ServiceListScreen> {
  ServiceCateBloc cateBloc;
  StreamSubscription sub;
  StreamSubscription serviceListBlocSub;
  ServiceListBloc serviceListBloc;

  @override
  void initState() {
    super.initState();
    cateBloc = context.bloc<ServiceCateBloc>();
    serviceListBloc = context.bloc<ServiceListBloc>();

    sub = cateBloc.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: () {
              popScreen();
            },
          );
        } else {
          serviceListBloc.loadInitDataWithCate(
              cateId: state.item
                  ?.firstWhere(
                    (element) => true,
                    orElse: () => null,
                  )
                  ?.id);
        }
      } else if (state.loading) {
        showLoading();
      }
    });

    serviceListBlocSub = serviceListBloc.listen((state) {
      if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
        showKayleeAlertErrorYesDialog(context: context, error: state.error);
      }
    });

    cateBloc.loadInitData();
  }

  @override
  void dispose() {
    sub.cancel();
    serviceListBlocSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: KayleeTabView(
            appBar: KayleeAppBar(
              title: Strings.danhMucDichVu,
              actions: <Widget>[
                FilterButton<ServiceFilter>(
                  controller: serviceListBloc,
                )
              ],
            ),
            tabBar: BlocBuilder<ServiceCateBloc, SingleModel<List<Category>>>(
              buildWhen: (previous, current) {
                return !current.loading;
              },
              builder: (context, state) {
                final categories = state.item;
                return KayleeTabBar(
                  itemCount: categories?.length,
                  mapTitle: (index) => categories.elementAt(index).name,
                  onSelected: (value) {
                    serviceListBloc.changeTab(
                        cateId: cateBloc.state.item.elementAt(value).id);
                  },
                );
              },
            ),
            pageView: KayleeRefreshIndicator(
              controller: serviceListBloc,
              child: KayleeLoadMoreHandler(
                controller: serviceListBloc,
                child: BlocConsumer<ServiceListBloc, LoadMoreModel<Service>>(
                  listener: (context, state) {
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
                  },
                  builder: (context, state) {
                    return KayleeGridView(
                      padding: EdgeInsets.all(Dimens.px16),
                      childAspectRatio: 103 / 195,
                      itemBuilder: (c, index) {
                        final item = state.items.elementAt(index);
                        return KayleeProdItemView.canTap(
                          data: KayleeProdItemData(
                              name: item.name,
                              image: item.image,
                              price: item.price),
                          onTap: () {
                            pushScreen(PageIntent(
                                screen: CreateNewServiceScreen,
                                bundle: Bundle(NewServiceScreenData(
                                    openFrom: ServiceScreenOpenFrom.serviceItem,
                                    service: item))));
                          },
                        );
                      },
                      itemCount: state.items?.length,
                      loadingBuilder: (context) {
                        if (state.ended) return Container();
                        return Align(
                          alignment: Alignment.topCenter,
                          child: CupertinoActivityIndicator(
                            radius: Dimens.px16,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        KayleeMenuFloatButton(
          mainItem: MenuFloatItem(
            title: Strings.taoDichVuMoi,
            onTap: () {
              pushScreen(PageIntent(
                  screen: CreateNewServiceScreen,
                  bundle: Bundle(NewServiceScreenData(
                      openFrom: ServiceScreenOpenFrom.addNewServiceBtn))));
            },
          ),
          secondItem: MenuFloatItem(
            title: Strings.quanLyDanhMuc,
            onTap: () {
              pushScreen(PageIntent(
                screen: ServCateListScreen,
              ));
            },
          ),
        )
      ],
    );
  }

  @override
  void onReloadWidget(Type widget, Bundle bundle) {
    if (widget == ServCateListScreen) {
      cateBloc.refresh();
    }
  }
}
