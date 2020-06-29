import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/branch/list/widgets/branch_item.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class BranchListScreen extends StatefulWidget {
  static Widget newInstance() => BranchListScreen._();

  BranchListScreen._();

  @override
  _BranchListScreenState createState() => _BranchListScreenState();
}

class _BranchListScreenState extends BaseState<BranchListScreen> {
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
