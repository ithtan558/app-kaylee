import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class BrandProdListScreen extends StatefulWidget {
  static Widget newInstance() => BrandProdListScreen._();

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
    return KayleeTabView(
      appBar: KayleeAppBar(
        titleWidget: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Shiseido_logo.svg/1280px-Shiseido_logo.svg.png',
          height: Dimens.px15,
        ),
        actions: <Widget>[
          KayleeAppBarAction.button(
            onTap: () {
              pushScreen(PageIntent(screen: CartScreen));
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  Images.ic_bag,
                  width: Dimens.px24,
                  height: Dimens.px32,
                ),
                Positioned(
                  child: KayleeText.normalWhite12W400('0'),
                  bottom: Dimens.px5,
                )
              ],
            ),
          )
        ],
      ),
      body: _buildProdList(),
      floatingActionButton: Material(
        color: Colors.transparent,
        type: MaterialType.circle,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: Dimens.px56,
            width: Dimens.px56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                    color: ColorsRes.shadow.withOpacity(0.2),
                    offset: const Offset(Dimens.px5, Dimens.px5),
                    blurRadius: Dimens.px10,
                    spreadRadius: 0)
              ],
            ),
            child: Image.asset(Images.ic_message),
          ),
        ),
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
            pushScreen(PageIntent(screen: ProductDetailScreen));
          },
        );
      },
      itemCount: 4,
    );
  }
}
