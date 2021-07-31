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
      ], child: const ServiceListScreen());

  @visibleForTesting
  const ServiceListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends KayleeState<ServiceListScreen> {
  ServiceCateBloc get cateBloc => context.bloc<ServiceCateBloc>()!;
  late StreamSubscription sub;

  ServiceListBloc get serviceListBloc => context.bloc<ServiceListBloc>()!;
  late StreamSubscription serviceListBlocSub;

  @override
  void initState() {
    super.initState();

    sub = cateBloc.stream.listen((state) {
      if (!cateBloc.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: () {
              popScreen();
            },
          );
        } else {
          int? categoryId;
          try {
            categoryId = (cateBloc.items?.firstWhere((element) => true))?.id;
          } catch (_) {}
          serviceListBloc.loadInitDataWithCate(cateId: categoryId);
        }
      } else if (cateBloc.loading) {
        showLoading();
      }
    });

    serviceListBlocSub = serviceListBloc.stream.listen((state) {
      if (state.error != null) {
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
                return !cateBloc.loading;
              },
              builder: (context, state) {
                final categories = cateBloc.items;
                return KayleeTabBar(
                  itemCount: categories?.length ?? 0,
                  mapTitle: (index) => categories!.elementAt(index).name,
                  onSelected: (index) {
                    serviceListBloc.changeTab(
                        cateId: cateBloc.items!.elementAt(index).id);
                  },
                );
              },
            ),
            pageView: BlocConsumer<ServiceListBloc, LoadMoreModel<Service>>(
              listener: (context, state) {
                if (state.error != null) {
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
                return PaginationRefreshGridView<Service>(
                  controller: serviceListBloc,
                  onRefresh: () async {
                    await cateBloc.refresh();
                    await serviceListBloc.refresh();
                  },
                  padding: const EdgeInsets.all(Dimens.px16),
                  gridDelegate:
                      KayleeGridView.gridDelegate(childAspectRatio: 103 / 195),
                  itemBuilder: (context, index, item) {
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
                  loadingIndicatorBuilder: (context) =>
                      const KayleeLoadingIndicator(),
                );
              },
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
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == ServCateListScreen) {
      cateBloc.refresh();
    } else if (widget == ServiceListScreen) {
      serviceListBloc.refresh();
    }
  }

  @override
  void onForceReloadingWidget() {
    cateBloc.refresh();
  }
}
