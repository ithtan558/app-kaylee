import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class BrandSelectList extends StatefulWidget {
  final ScrollController controller;

  BrandSelectList({this.controller});

  @override
  _BrandSelectListState createState() => _BrandSelectListState();
}

class _BrandSelectListState extends BaseState<BrandSelectList> {
  int selectedIndex;

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
    print('[TUNG] ===> build');

    return Column(
      children: [
        KayleeText.normal18W700(
          'Chọn cửa hàng cần áp dụng',
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
        Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.all(Dimens.px16),
                controller: widget.controller,
                itemBuilder: (c, index) {
                  if (index == 0)
                    return buildItem(
                      title: 'Tất cả',
                      isSelected: selectedIndex == 0,
                      onTap: () {
                        setState(() {
                          selectedIndex = selectedIndex == index ? null : index;
                        });
                      },
                    );
                  return buildItem(
                    title: 'Item 1',
                    isSelected: selectedIndex == 0 || selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = selectedIndex == index ? null : index;
                      });
                    },
                  );
                },
                separatorBuilder: (c, _) => SizedBox(
                  height: Dimens.px8,
                ),
                itemCount: 10 + 1)),
        Container(
          height: Dimens.px1,
          width: double.infinity,
          color: ColorsRes.divider,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.px8, vertical: Dimens.px16),
          child: Row(
            children: [
              Expanded(
                child: KayLeeRoundedButton.button2(
                  margin: EdgeInsets.zero,
                  text: Strings.huyBo,
                  onPressed: () {
                    popScreen();
                  },
                ),
              ),
              SizedBox(width: Dimens.px8),
              Expanded(
                child: KayLeeRoundedButton.normal(
                  margin: EdgeInsets.zero,
                  text: Strings.xacNhan,
                  onPressed: () {
                    popScreen();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildItem(
      {String title, bool isSelected = false, VoidCallback onTap}) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: isSelected ? ColorsRes.hyper : ColorsRes.background,
      borderRadius: BorderRadius.circular(Dimens.px5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: Dimens.px40,
          padding: const EdgeInsets.all(Dimens.px8),
          child: Row(
            children: [
              Image.asset(
                isSelected ? Images.ic_checked_1 : Images.ic_notcheck,
                width: Dimens.px24,
                height: Dimens.px24,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: Dimens.px8),
                  child: KayleeText(
                    title ?? '',
                    maxLines: 1,
                    style: isSelected
                        ? TextStyles.normalWhite16W400
                        : TextStyles.normal16W400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
