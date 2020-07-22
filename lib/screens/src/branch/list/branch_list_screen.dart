import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/branch/list/bloc/brand_list_bloc.dart';
import 'package:kaylee/screens/src/branch/list/widgets/branch_item.dart';
import 'package:kaylee/screens/src/branch/list/widgets/brand_filter_list.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class BranchListScreen extends StatefulWidget {
  static Widget newInstance() => CubitProvider(
        create: (context) =>
            BrandListBloc(brandService: context.network.provideBrandService()),
        child: BranchListScreen._(),
      );

  BranchListScreen._();

  @override
  _BranchListScreenState createState() => _BranchListScreenState();
}

class _BranchListScreenState extends KayleeState<BranchListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeFilterPopUpView(
      appBar: KayleeAppBar(
        title: Strings.dsChiNhanh,
      ),
      filterTags: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
        itemBuilder: (context, index) {
          return KayleeFilterListItem(
            title: 'Tất cả',
            disable: true,
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: Dimens.px8),
      ),
      filterList: BrandFilterList.newInstance(),
      body: ListView.separated(
          padding: const EdgeInsets.only(
              bottom: Dimens.px16,
              top: Dimens.px8,
              right: Dimens.px16,
              left: Dimens.px16),
          itemBuilder: (c, index) {
            return BranchItem(
              onTap: () {
                pushScreen(PageIntent(
                    screen: CreateNewBranchScreen,
                    bundle: Bundle(NewBranchScreenData(
                        openFrom: BranchScreenOpenFrom.branchItem))));
              },
            );
          },
          separatorBuilder: (c, index) {
            return SizedBox(
              height: Dimens.px16,
            );
          },
          itemCount: 10),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(
              screen: CreateNewBranchScreen,
              bundle: Bundle(NewBranchScreenData(
                  openFrom: BranchScreenOpenFrom.addNewBranchBtn))));
        },
      ),
    );
  }
}
