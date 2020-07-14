import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/history_detail/history_detail_screen.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryTab extends StatefulWidget {
  static Widget newInstance() => HistoryTab._();

  HistoryTab._();

  @override
  _HistoryTabState createState() => new _HistoryTabState();
}

class _HistoryTabState extends BaseState<HistoryTab> {
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
    return KayleeFilterView(
      title: Strings.lichSuDh,
      child: ListView.separated(
          padding: EdgeInsets.all(Dimens.px16),
          itemBuilder: (c, index) {
            return _buildHistItem(isCancel: index % 2 == 0);
          },
          separatorBuilder: (c, index) {
            return Container(
              height: Dimens.px16,
            );
          },
          itemCount: 10),
    );
  }

  _buildHistItem({bool isCancel = false}) {
    return Container(
      height: Dimens.px77,
      width: double.infinity,
      child: Material(
        color: isCancel ? ColorsRes.textFieldBorder : Colors.white,
        elevation: Dimens.px5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.px5),
            side: BorderSide(
                width: Dimens.px1, color: ColorsRes.textFieldBorder)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            pushScreen(PageIntent(screen: HistoryDetailScreen));
          },
          child: Row(
            children: [
              Container(
                width: Dimens.px68,
                height: double.infinity,
                color: ColorsRes.textFieldBorder,
                alignment: Alignment.center,
                child: KayleeText.normal16W500("#001",
                    textAlign: TextAlign.center),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KayleeText.normal16W500(
                      "Thu Nguyen",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px8),
                      child: KayleePriceText.normal(700000,
                          textStyle: TextStyles.hint16W400),
                    )
                  ],
                ),
              )),
              Container(
                width: Dimens.px76,
                height: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                  color: ColorsRes.textFieldBorder,
                  width: Dimens.px1,
                ))),
                alignment: Alignment.center,
                child: KayleeText.normal16W400(
                  "Hoàn thành",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
