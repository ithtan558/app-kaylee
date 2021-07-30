import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_service_item_list/bloc/select_service_cate_bloc.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_service_item_list/bloc/select_service_list_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectServiceList extends StatefulWidget {
  static Widget newInstance({
    List<Service>? initialValue,
    required ValueChanged<List<Service>> onConfirm,
    VoidCallback? onCancel,
    required Brand brand,
  }) =>
      MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SelectServiceCateBloc(
                servService: context.network.provideServService(),
              ),
            ),
            BlocProvider(
              create: (context) => SelectServiceListBloc(
                servService: context.network.provideServService(),
                initialData: initialValue,
                brand: brand,
              ),
            ),
          ],
          child: SelectServiceList._(
            onConfirm: onConfirm,
            onCancel: onCancel,
          ));

  final ValueChanged<List<Service>> onConfirm;
  final VoidCallback? onCancel;

  SelectServiceList._({required this.onConfirm, this.onCancel});

  @override
  _SelectServiceListState createState() => _SelectServiceListState();
}

class _SelectServiceListState extends KayleeState<SelectServiceList> {
  SelectServiceCateBloc get cateBloc => context.bloc<SelectServiceCateBloc>()!;
  late StreamSubscription cateBlocSub;

  SelectServiceListBloc get serviceListBloc =>
      context.bloc<SelectServiceListBloc>()!;
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    cateBlocSub = cateBloc.stream.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: popScreen,
          );
        } else {
          int? cateId;
          try {
            {
              cateId = (state.item?.firstWhere(
                (element) => true,
              ))?.id;
            }
          } catch (_) {}
          serviceListBloc.loadInitDataWithCate(cateId: cateId);
        }
      }
    });
    _sub = serviceListBloc.stream.listen((state) {
      if (state.error != null) {
        showKayleeAlertErrorYesDialog(context: context, error: state.error);
      }
    });
    cateBloc.loadInitData();
  }

  @override
  void dispose() {
    cateBlocSub.cancel();
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeTabView(
      bgColor: Colors.white,
      tabBar:
          BlocBuilder<SelectServiceCateBloc, SingleModel<List<ServiceCate>>>(
        buildWhen: (previous, current) => !current.loading,
        builder: (context, state) {
          final categories = state.item;
          return KayleeTabBar(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
            itemCount: categories?.length ?? 0,
            mapTitle: (index) => categories?.elementAt(index).name,
            onSelected: (value) {
              serviceListBloc.changeTab(
                  cateId: cateBloc.state.item?.elementAt(value).id);
            },
          );
        },
      ),
      pageView: Column(
        children: [
          Expanded(
            child: KayleeRefreshIndicator(
              controller: serviceListBloc,
              child: KayleeLoadMoreHandler(
                controller: serviceListBloc,
                child:
                    BlocConsumer<SelectServiceListBloc, LoadMoreModel<Service>>(
                  listener: (context, state) {
                    if (state.error != null) {
                      showKayleeAlertErrorYesDialog(
                        context: context,
                        error: state.error,
                        onPressed: popScreen,
                      );
                    }
                  },
                  builder: (context, state) {
                    return KayleeGridView(
                      padding: EdgeInsets.all(Dimens.px8),
                      childAspectRatio: 103 / 195,
                      itemBuilder: (c, index) {
                        final item = state.items!.elementAt(index);
                        return KayleeProdItemView.canSelect(
                          data: KayleeProdItemData(
                              name: item.name,
                              image: item.image,
                              price: item.price),
                          onSelect: (selected) {
                            serviceListBloc.select(service: item);
                          },
                          selected: item.selected,
                        );
                      },
                      itemCount: state.items?.length,
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
          Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: Row(
              children: [
                Expanded(
                  child: KayLeeRoundedButton.button2(
                    text: Strings.huy,
                    margin: const EdgeInsets.only(right: Dimens.px8),
                    onPressed: () {
                      widget.onCancel?.call();
                      popScreen();
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<SelectServiceListBloc,
                      LoadMoreModel<Service>>(
                    builder: (context, state) {
                      final enable =
                          serviceListBloc.selectedServices.isNotEmpty;
                      return enable
                          ? KayLeeRoundedButton.normal(
                              text: Strings.xacNhan,
                              margin: const EdgeInsets.only(left: Dimens.px8),
                              onPressed: () {
                                widget.onConfirm
                                    .call(serviceListBloc.selectedServices);
                                popScreen();
                              },
                            )
                          : KayLeeRoundedButton.button3(
                              text: Strings.xacNhan,
                              margin: const EdgeInsets.only(left: Dimens.px8),
                            );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
