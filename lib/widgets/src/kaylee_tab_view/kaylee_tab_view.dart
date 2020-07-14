import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeTabView extends StatefulWidget {
  final KayleeAppBar appBar;
  final Widget body;
  final Widget floatingActionButton;

  KayleeTabView({this.appBar, this.body, this.floatingActionButton});

  @override
  _KayleeTabViewState createState() => _KayleeTabViewState();
}

class _KayleeTabViewState extends BaseState<KayleeTabView>
    with SingleTickerProviderStateMixin {
  final list = [
    'Phụ kiện cưới',
    'Phụ kiện cưới',
    'Phụ kiện cưới',
    'Phụ kiện cưới',
    'Phụ kiện cưới',
  ];

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
      appBar: widget.appBar,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimens.px16),
            height: Dimens.px40,
            child: _KayleeTabBar(
              tabs: list,
            ),
          ),
          Expanded(
              child: Stack(
            children: [
              widget.body ??
                  Container(
                    color: Colors.transparent,
                  ),
              Positioned(
                child: widget.floatingActionButton ?? Container(),
                right: Dimens.px24,
                bottom: Dimens.px24,
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class _KayleeTabBar extends StatefulWidget {
  final List<String> tabs;
  final ValueSetter<int> onChange;

  _KayleeTabBar({this.tabs, this.onChange});

  @override
  _KayleeTabBarState createState() => _KayleeTabBarState();
}

class _KayleeTabBarState extends BaseState<_KayleeTabBar> {
  int currentIndex = 0;

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
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return buildTabItem(
          title: widget.tabs.elementAt(index),
          isSelected: index == currentIndex,
          onTap: () {
            setState(() {
              currentIndex = index;
            });
            if (widget.onChange.isNotNull) {
              widget.onChange(currentIndex);
            }
          },
        );
      },
      separatorBuilder: (context, index) => Container(
        width: Dimens.px16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      itemCount: widget.tabs.length,
    );
  }

  Widget buildTabItem(
      {String title, bool isSelected = false, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.px5),
            color: Colors.white,
            border: Border.fromBorderSide(BorderSide(
                color: isSelected ? ColorsRes.hyper : ColorsRes.textFieldBorder,
                width: isSelected ? Dimens.px2 : Dimens.px1))),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
        alignment: Alignment.center,
        child: isSelected
            ? KayleeText.hyper16W400(
                title ?? '',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              )
            : KayleeText.normal16W400(
                title ?? '',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
