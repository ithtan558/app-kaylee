import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

class KayleeTabView extends StatefulWidget {
  final KayleeAppBar? appBar;
  final Widget? floatingActionButton;
  final Widget? tabBar;
  final Widget? pageView;
  final Color? bgColor;

  const KayleeTabView({Key? key,
    this.appBar,
    this.tabBar,
    this.floatingActionButton,
    this.pageView,
    this.bgColor})
      : super(key: key);

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
      backgroundColor: widget.bgColor ?? context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          if (widget.tabBar != null)
            Container(
              margin: const EdgeInsets.only(top: Dimens.px16),
              height: Dimens.px40,
              child: widget.tabBar,
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
  final ValueSetter<int>? onSelected;
  final int itemCount;
  final String? Function(int index)? mapTitle;
  final EdgeInsets? padding;

  const KayleeTabBar({
    Key? key,
    required this.itemCount,
    required this.mapTitle,
    this.onSelected,
    this.padding,
  }) : super(key: key);

  @override
  _KayleeTabBarState createState() => _KayleeTabBarState();
}

class _KayleeTabBarState extends BaseState<KayleeTabBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return buildTabItem(
          title: widget.mapTitle?.call(index),
          isSelected: index == currentIndex,
          onTap: () {
            setState(() {
              currentIndex = index;
            });
            widget.onSelected?.call(currentIndex);
          },
        );
      },
      separatorBuilder: (context, index) => Container(
        width: Dimens.px16,
      ),
      padding:
      widget.padding ?? const EdgeInsets.symmetric(horizontal: Dimens.px16),
      itemCount: widget.itemCount,
    );
  }

  Widget buildTabItem({String? title, bool isSelected = false, VoidCallback? onTap}) {
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
  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final PageController? controller;

  const KayleePageView({Key? key, this.itemCount, required this.itemBuilder, this.controller})
      : super(key: key);

  @override
  _KayleePageViewState createState() => _KayleePageViewState();
}

class _KayleePageViewState extends BaseState<KayleePageView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: widget.itemBuilder,
      controller: widget.controller,
      itemCount: widget.itemCount ?? 0,
    );
  }
}
