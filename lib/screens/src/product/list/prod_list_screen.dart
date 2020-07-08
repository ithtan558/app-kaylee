import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ProdListScreen extends StatefulWidget {
  static Widget newInstance() => ProdListScreen._();

  ProdListScreen._();

  @override
  _ProdListScreenState createState() => _ProdListScreenState();
}

class _ProdListScreenState extends BaseState<ProdListScreen> {
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
    return KayleeTabView(
      appBar: KayleeAppBar(
        title: Strings.danhMucSanPham,
      ),
      body: _buildProdList(),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(
              screen: CreateNewProdScreen,
              bundle: Bundle(NewProdScreenData(
                  openFrom: NewProdScreenOpenFrom.addNewProdBtn))));
        },
      ),
    );
  }

  _buildProdList() {
    return KayleeGridView(
      padding: EdgeInsets.all(Dimens.px16),
      childAspectRatio: 103 / 195,
      itemBuilder: (c, index) {
        return KayleeProdItemView.canTap(
          data: KayleeProdItemData(
              name: 'Tóc kiểu thôn nữ',
              image:
                  'https://img.jakpost.net/c/2019/12/09/2019_12_09_83333_1575827116._large.jpg',
              price: 600000),
          onTap: () {
            pushScreen(PageIntent(
                screen: CreateNewProdScreen,
                bundle: Bundle(NewProdScreenData(
                    openFrom: NewProdScreenOpenFrom.prodItem))));
          },
        );
      },
      itemCount: 4,
    );
  }
}
