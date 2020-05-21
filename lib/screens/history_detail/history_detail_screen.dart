import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class HistoryDetailScreen extends StatefulWidget {
  factory HistoryDetailScreen.newInstance() = HistoryDetailScreen._;

  HistoryDetailScreen._();

  @override
  _HistoryDetailScreenState createState() => new _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends BaseState<HistoryDetailScreen> {
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
        title: Strings.chiTietDH,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimens.px16),
        child: Column(
          children: [
            KayleeTextField.staticWidget(
              title: Strings.thongTinKh,
              initText: 'David Park',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
              child: KayleeTextField.staticWidget(
                title: Strings.chiNhanh,
                initText: 'David Park',
              ),
            ),

            KayleeFlatButton.normal(
              onPress: (){},
              title: 'Thêm mục',
            )
          ],
        ),
      ),
    );
  }
}
