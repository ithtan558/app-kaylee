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
        title: Strings.danhSachSanPham,
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {},
      ),
    );
  }
}
