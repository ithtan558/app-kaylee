import 'package:flutter/material.dart';
import 'package:kaylee/widgets/widgets.dart';

class ServCateDetailScreen extends StatefulWidget {
  static Widget newInstance() => ServCateDetailScreen._();

  ServCateDetailScreen._();

  @override
  _ServCateDetailScreenState createState() => _ServCateDetailScreenState();
}

class _ServCateDetailScreenState extends State<ServCateDetailScreen> {
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
