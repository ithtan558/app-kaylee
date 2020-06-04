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
              return _buildBackGroundItem(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimens.px16),
                    color: ColorsRes.color2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: KayleeText.normal16W500(Strings.doanhThu)),
                        KayleeDatePickerText(
                          onSelect: (changed) {},
                        ),
                      ],
                    ),
                  ),
                  KayleeDateRangePickerText()
                ],
              ));
            } else
              return Container();
          },
          separatorBuilder: (_, index) => Container(
                height: Dimens.px16,
              ),
          itemCount: 4),
    );
  }

  _buildBackGroundItem({Widget child}) {
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
        child: child,
      ),
    );
  }
}
