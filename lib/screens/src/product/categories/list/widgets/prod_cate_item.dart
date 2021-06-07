import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProdCateItem extends CategoryItem {
  ProdCateItem({required ProdCate category, required VoidCallback onTap})
      : super(
          index: category.sequence,
          name: category.name,
          onTap: onTap,
        );
}
