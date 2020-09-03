import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/widgets/widgets.dart';

class ServCateItem extends CategoryItem {
  ServCateItem({ServiceCate category, VoidCallback onTap})
      : super(
          index: category.sequence,
          name: category.name,
          onTap: onTap,
        );
}
