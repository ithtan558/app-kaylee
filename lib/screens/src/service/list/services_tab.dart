import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/service/list/bloc/service_list_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class ServicesTab extends StatefulWidget {
  static Widget newInstance() => BlocProvider<ServiceListBloc>(
        create: (context) => ServiceListBloc(
            servService:
                context.repository<NetworkModule>().provideServService(),
            cateId: context.repository<Category>().id),
        child: ServicesTab._(),
      );

  ServicesTab._();

  @override
  _ServicesTabState createState() => _ServicesTabState();
}

class _ServicesTabState extends KayleeState<ServicesTab> {
  ServiceListBloc serviceTabBloc;
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    serviceTabBloc = context.bloc<ServiceListBloc>()
      ..loadServices();
    sub = serviceTabBloc.listen((state) {
      if (state.code.isNotNull) {
        showKayleeAlertErrorYesDialog(context: context, error: state.error);
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeLoadMoreHandler(
      controller: context.bloc<ServiceListBloc>(),
      child: BlocBuilder<ServiceListBloc, LoadMoreModel<Service>>(
        buildWhen: (previous, current) {
          return !current.loading;
        },
        builder: (context, state) {
          return KayleeGridView(
            padding: EdgeInsets.all(Dimens.px16),
            childAspectRatio: 103 / 195,
            itemBuilder: (c, index) {
              final item = state.items.elementAt(index);
              return KayleeProdItemView.canTap(
                data: KayleeProdItemData(
                    name: item.name, image: item.image, price: item.price),
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
    );
  }
}
