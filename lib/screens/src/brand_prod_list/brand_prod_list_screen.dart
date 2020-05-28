import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class BrandProdListScreen extends StatefulWidget {
  factory BrandProdListScreen.newInstance() = BrandProdListScreen._;

  BrandProdListScreen._();

  @override
  _BrandProdListScreenState createState() => new _BrandProdListScreenState();
}

class _BrandProdListScreenState extends BaseState<BrandProdListScreen> {
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
        titleWidget: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Shiseido_logo.svg/1280px-Shiseido_logo.svg.png',
          height: Dimens.px15,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (c, index) {
          return _buildProdList();
        },
        itemCount: 3,
      ),
    );
  }

  _buildProdList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
          child: KayleeText("Chưa có danh mục (1)",
              style: TextStyles.normal16W500),
        ),
        GridView.builder(
          padding: EdgeInsets.all(Dimens.px16),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Dimens.px16,
              mainAxisSpacing: Dimens.px16,
              childAspectRatio: 103 / 195),
          itemBuilder: (c, index) {
            return KayleeProdItem();
          },
          itemCount: 4,
        )
      ],
    );
  }
}
