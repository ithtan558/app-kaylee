import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  factory ProductDetailScreen.newInstance() = ProductDetailScreen._;

  ProductDetailScreen._();

  @override
  _ProductDetailScreenState createState() => new _ProductDetailScreenState();
}

class _ProductDetailScreenState extends BaseState<ProductDetailScreen> {
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
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.chiTietSanPham,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                'https://stylspire.com/wp-content/uploads/2019/04/featured-vegan-natural-beauty.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimens.px16, left: Dimens.px16, right: Dimens.px16),
              child: KayleeText.normal16W500(
                'TÓC KIỂU THÔN NỮ'.toUpperCase(),
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimens.px8, left: Dimens.px16, right: Dimens.px16),
              child: KayleePriceText.hyper16W700(700000),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimens.px8, left: Dimens.px16, right: Dimens.px16),
              child: KayleeText.normal16W400(
                  'Mô tả sản phẩm cung cấp cho khách hàng những thông tin mà hình ảnh hay video có '
                  'thể không thể hiện được, chẳng hạn như chất liệu, nguồn gốc hay kích cỡ. '
                  'Những thông tin này đôi khi ảnh hưởng rất lớn tới quyết định mua hàng của một người. '
                  'Nếu không hiểu sản phẩm có lợi ích gì, họ sẵn sàng rời store '
                  'của bạn để chuyển sang một store khác.'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimens.px16, left: Dimens.px16, right: Dimens.px16),
              child: KayleeTextField.selection(
                title: 'Chọn loại sản phẩm',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimens.px24,
                  left: Dimens.px16,
                  right: Dimens.px16,
                  bottom: Dimens.px8),
              child: Row(
                children: [
                  KayleeIncrAndDecrButtons(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: Dimens.px16),
                      child: KayLeeRoundedButton.normal(
                        text: Strings.themVaoGioHang,
                        margin: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
