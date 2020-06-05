import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class RevenueScreen extends StatefulWidget {
  factory RevenueScreen.newInstance() = RevenueScreen._;

  RevenueScreen._();

  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends BaseState<RevenueScreen> {
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
        title: Strings.doanhThuBH,
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(Dimens.px16),
          itemBuilder: (c, index) {
            if (index == 0) {
              return KayleeFlatButton.filter(
                child: Row(children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: KayleeText.normalWhite16W400(
                      'Tất cả chi nhánh',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  Image.asset(
                    Images.ic_triangle_down,
                    color: Colors.white,
                    width: Dimens.px16,
                    height: Dimens.px16,
                  )
                ]),
                background: ColorsRes.button,
                onPress: () {},
              );
            } else if (index == 1) {
              return buildBackGroundItem(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: KayleeText.normal16W500(Strings.doanhThu)),
                      KayleeDatePickerText(
                        onSelect: (changed) {},
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Dimens.px16,
                            left: Dimens.px16,
                            right: Dimens.px16,
                            bottom: Dimens.px8),
                        child: KayleeText.hint16W400(
                          'Tổng doanh thu',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Dimens.px16,
                            right: Dimens.px16,
                            bottom: Dimens.px16),
                        child: KayleePriceText.noUnitNormal26W700(
                          29000000,
                        ),
                      ),
                      Row(
                        children: [
                          buildTotalRevenue(title: 'Tiền mặt', price: 19000000),
                          buildTotalRevenue(
                              title: 'Tài khoản', price: 10000000),
                        ],
                      )
                    ],
                  ));
            } else if (index == 2) {
              return buildBackGroundItem(
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KayleeText.normal16W500(
                        'So sánh doanh thu',
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Dimens.px8),
                        child: KayleeDateRangePickerText(
                          onSelect: (from, to) {},
                        ),
                      ),
                    ],
                  ),
                  child: Container());
            } else
              return buildBackGroundItem(
                  header: Row(
                    children: [
                      Expanded(
                        child: KayleeText.normal16W500(
                          'Doanh thu mỗi nhân viên',
                          maxLines: 1,
                        ),
                      ),
                      KayleeDatePickerText(
                        onSelect: (changed) {},
                      ),
                    ],
                  ),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (c, index) {
                        return Padding(
                          padding: const EdgeInsets.all(Dimens.px16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: KayleeText.normal16W500(
                                  'Maria',
                                ),
                              ),
                              KayleePriceText.noUnitNormal16W400(200000),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: Dimens.px4),
                                child: KayleeText.hint16W400(Strings.vnd),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (c, index) {
                        return Container(
                            height: Dimens.px1,
                            decoration:
                                BoxDecoration(color: Color(0xffdfdfe3)));
                      },
                      itemCount: 5));
          },
          separatorBuilder: (_, index) => Container(
                height: Dimens.px16,
              ),
          itemCount: 4),
    );
  }

  buildBackGroundItem({Widget header, Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.px10),
        boxShadow: [
          const BoxShadow(
              color: ColorsRes.shadow,
              offset: Offset(0, 1),
              blurRadius: Dimens.px5,
              spreadRadius: 0)
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(Dimens.px10),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.px16),
              color: ColorsRes.color2,
              child: header ?? Container(),
            ),
            child ?? Container(),
          ],
        ),
      ),
    );
  }

  Widget buildTotalRevenue({String title, dynamic price}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: Dimens.px21, bottom: Dimens.px20),
        child: Column(
          children: [
            KayleeText.hint16W400(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            KayleePriceText.noUnitNormal18W700(
              price,
            )
          ],
        ),
      ),
    );
  }
}
