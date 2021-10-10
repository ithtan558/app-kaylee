import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';

class ProdCateItem extends CategoryItem {
  ProdCateItem({Key? key, required ProdCate category, required VoidCallback onTap})
      : super(
    key: key,
    index: category.sequence,
    name: category.name,
    onTap: onTap,
  );
}
