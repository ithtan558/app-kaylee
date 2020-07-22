import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/branch/list/bloc/brand_filter_list_list_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class BrandFilterList extends StatefulWidget {
  static Widget newInstance() => MultiCubitProvider(providers: [
        CubitProvider<CityBloc>(
          create: (context) =>
              CityBloc(commonService: context.network.provideCommonService()),
        ),
        CubitProvider<DistrictBloc>(
          create: (context) => DistrictBloc(
              commonService: context.network.provideCommonService()),
        ),
      ], child: BrandFilterList._());

  BrandFilterList._();

  @override
  _BrandFilterListState createState() => _BrandFilterListState();
}

class _BrandFilterListState extends State<BrandFilterList>
    with AutomaticKeepAliveClientMixin {
  CityBloc cityBloc;
  DistrictBloc districtBloc;

  @override
  void initState() {
    super.initState();
    cityBloc = context.cubit<CityBloc>()..loadCity();
    districtBloc = context.cubit<DistrictBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      padding: const EdgeInsets.only(
          left: Dimens.px24,
          right: Dimens.px24,
          top: Dimens.px24,
          bottom: Dimens.px16),
      itemBuilder: (c, index) {
        if (index == 0) {
          return WrapperFilter(
            title: 'Chọn lọc',
            isAll: true,
            children: <Widget>[
              KayleeFilterListItem(
                title: 'Tất cả',
                onTap: (isSelected) {},
              )
            ],
          );
        } else if (index == 1) {
          return CubitBuilder<CityBloc, SingleModel<List<City>>>(
            builder: (context, state) {
              return WrapperFilter(
                title: 'Theo Tỉnh/Thành',
                children: state.item
                        .map<KayleeFilterListItem>((e) => KayleeFilterListItem(
                              title: e.name,
                              onTap: (isSelected) {},
                            ))
                        .toList() ??
                    [],
              );
            },
          );
        } else {
          return CubitBuilder<DistrictBloc, SingleModel<List<District>>>(
            builder: (context, state) {
              if (state.item.isEmpty) return Container();
              return WrapperFilter(
                title: 'Theo Quận',
                children: state.item
                        .map<KayleeFilterListItem>((e) => KayleeFilterListItem(
                              title: e.name,
                              onTap: (isSelected) {},
                            ))
                        .toList() ??
                    [],
              );
            },
          );
        }
      },
      itemCount: 2 + 1,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: Dimens.px16,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
