import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class HistoryTab extends StatefulWidget {
  factory HistoryTab.newInstance() = HistoryTab._;

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
          padding: EdgeInsets.only(
              left: Dimens.px16,
              right: Dimens.px16,
              top: Dimens.px24,
              bottom: Dimens.px16),
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
    print('[TUNG] ===> $isCancel');
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
          onTap: () {},
          child: Row(
            children: [
              Container(
                width: Dimens.px68,
                height: double.infinity,
                color: ColorsRes.textFieldBorder,
                alignment: Alignment.center,
                child: Text("#001",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyText2.copyWith(
                      fontSize: Dimens.px16,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Thu Nguyen",
                        style: theme.textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px8),
                      child: Text("700.000đ",
                          style: theme.textTheme.bodyText2.copyWith(
                            color: ColorsRes.hintText,
                            fontWeight: FontWeight.w400,
                          )),
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
                child: Text("Hoàn thành",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Dimens.px16,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
