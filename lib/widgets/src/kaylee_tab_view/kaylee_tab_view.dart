import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeTabView extends StatefulWidget {
  final KayleeAppBar appBar;
  final Widget floatingActionButton;
  final Widget tabBar;
  final Widget pageView;

  KayleeTabView(
      {this.appBar, this.tabBar, this.floatingActionButton, this.pageView});

  @override
  _KayleeTabViewState createState() => _KayleeTabViewState();
}

class _KayleeTabViewState extends BaseState<KayleeTabView>
    with SingleTickerProviderStateMixin {
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
            child: widget.tabBar ?? Container(),
          ),
          Expanded(
              child: Stack(
            children: [
              Positioned.fill(
                child: widget.pageView ??
                    Container(
                      color: Colors.transparent,
                    ),
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

class KayleeTabBar extends StatefulWidget {
  final ValueSetter<int> onSelected;
  final int itemCount;
  final String Function(int index) mapTitle;
  final PageController pageController;

  KayleeTabBar(
      {@required this.itemCount,
      @required this.mapTitle,
      this.onSelected,
      this.pageController});

  @override
  _KayleeTabBarState createState() => _KayleeTabBarState();
}

class _KayleeTabBarState extends BaseState<KayleeTabBar> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController?.addListener(() {
      if (((widget.pageController?.page ?? 0) -
                  widget.pageController?.page?.toInt())
              .abs() ==
          0) {
        setState(() {
          currentIndex = widget.pageController.page.toInt();
        });
      }
    });
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
          title: widget.mapTitle?.call(index) ?? '',
          isSelected: index == currentIndex,
          onTap: () {
            setState(() {
              currentIndex = index;
            });
            widget.pageController?.jumpToPage(currentIndex);
            widget.onSelected?.call(currentIndex);
          },
        );
      },
      separatorBuilder: (context, index) =>
          Container(
            width: Dimens.px16,
          ),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      itemCount: widget.itemCount ?? 0,
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

class KayleePageView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final PageController controller;

  KayleePageView({this.itemCount, @required this.itemBuilder, this.controller});

  @override
  _KayleePageViewState createState() => _KayleePageViewState();
}

class _KayleePageViewState extends BaseState<KayleePageView> {
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
    return PageView.builder(
      itemBuilder: widget.itemBuilder,
      controller: widget.controller,
      itemCount: widget.itemCount ?? 0,
    );
  }
}
