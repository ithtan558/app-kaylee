import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/history_detail/widgets/service_item.dart';
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
        padding: EdgeInsets.symmetric(vertical: Dimens.px16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: KayleeTextField.staticWidget(
                title: Strings.thongTinKh,
                initText: 'David Park',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.px16, horizontal: Dimens.px16),
              child: KayleeTextField.staticWidget(
                title: Strings.chiNhanh,
                initText: 'David Park',
              ),
            ),
            LabelDividerView.normal(
              title: Strings.danhSachDichVu,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (c, index) {
                    return ServiceItem();
                  },
                  itemCount: 2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px16, left: Dimens.px16, right: Dimens.px16),
              child: KayleeTitlePriceText.normal(
                title: 'Tổng chi phí',
                price: 190000,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimens.px8, left: Dimens.px16, right: Dimens.px16),
              child: KayleeTitlePriceText.bold(
                title: 'Thành tiền',
                price: 190000,
              ),
            )
          ],
        ),
      ),
    );
  }
}
