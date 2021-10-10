import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';

class ServCateItem extends CategoryItem {
  ServCateItem({Key? key, required ServiceCate category, required VoidCallback onTap})
      : super(
    index: category.sequence,
    name: category.name,
    onTap: onTap,
    key: key,
  );
}
