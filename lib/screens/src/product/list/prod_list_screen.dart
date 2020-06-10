import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ProdListScreen extends StatefulWidget {
  factory ProdListScreen.newInstance() = ProdListScreen._;

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
    return KayleeFilterPopUpView(
      appBar: KayleeAppBar(
        title: Strings.danhMucSanPham,
      ),
      body: ListView.builder(
        itemBuilder: (c, index) {
          return _buildProdList();
        },
        itemCount: 3,
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {},
      ),
    );
  }

  _buildProdList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
          child: KayleeText.normal16W500(
            "Chưa có danh mục (1)",
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
          ),
        ),
        KayleeGridView(
          padding: EdgeInsets.all(Dimens.px16),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 103 / 195,
          itemBuilder: (c, index) {
            return KayleeProdItemView.canTap(
              data: KayleeProdItemData(
                  name: 'Tóc kiểu thôn nữ',
                  image:
                      'https://img.jakpost.net/c/2019/12/09/2019_12_09_83333_1575827116._large.jpg',
                  price: 600000),
              onTap: () {},
            );
          },
          itemCount: 4,
        )
      ],
    );
  }
}
