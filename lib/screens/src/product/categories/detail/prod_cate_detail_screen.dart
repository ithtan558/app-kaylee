import 'package:flutter/material.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProdCateDetailScreen extends StatefulWidget {
  static Widget newInstance() => ProdCateDetailScreen._();

  ProdCateDetailScreen._();

  @override
  _ProdCateDetailScreenState createState() => _ProdCateDetailScreenState();
}

class _ProdCateDetailScreenState extends State<ProdCateDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: 'Tạo danh mục mới',
      ),
    );
  }
}
