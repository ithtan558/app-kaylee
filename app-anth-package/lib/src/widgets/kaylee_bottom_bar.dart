import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeBottomBar extends StatefulWidget {
  final void Function(int index)? onTapChanged;
  final PageController? pageController;
  final List<KayleeBottomBarItem> items;

  const KayleeBottomBar({
    Key? key,
    required this.items,
    this.onTapChanged,
    this.pageController,
  }) : super(key: key);

  @override
  _KayleeBottomBarState createState() => _KayleeBottomBarState();
}

class _KayleeBottomBarState extends BaseState<KayleeBottomBar> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController?.addListener(handlePageChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.pageController?.removeListener(handlePageChange);
  }

  void handlePageChange() {
    setState(() {
      selectedTab = (widget.pageController?.page)?.toInt() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.items.map((item) => _buildBtmBarItem(item: item)).toList(),
      selectedLabelStyle: context.textTheme.bodyText2?.copyWith(
        fontSize: Dimens.px12,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: context.textTheme.bodyText2?.copyWith(
        fontSize: Dimens.px12,
      ),
      onTap: (index) {
        if (index != selectedTab) {
          setState(() {
            selectedTab = index;
            widget.onTapChanged?.call(selectedTab);
          });
        }
      },
      currentIndex: selectedTab,
      unselectedIconTheme: const IconThemeData(size: Dimens.px24),
      selectedIconTheme: const IconThemeData(size: Dimens.px24),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: ColorsRes.hyper,
      unselectedItemColor: ColorsRes.hintText,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    );
  }

  BottomNavigationBarItem _buildBtmBarItem(
      {required KayleeBottomBarItem item}) {
    return BottomNavigationBarItem(
      icon: item.icon.child ??
          _KayleeBottomBarIcon(
            icon: item.icon.path!,
            package: item.icon.package,
          ),
      activeIcon: item.activeIcon != null
          ? (item.activeIcon!.child ??
              _KayleeBottomBarIcon(
                icon: item.activeIcon!.path!,
                color: item.activeIcon!.color ?? ColorsRes.hyper,
                package: item.activeIcon!.package,
              ))
          : (item.icon.child ??
              _KayleeBottomBarIcon(
                icon: item.icon.path!,
                color: ColorsRes.hyper,
                package: item.icon.package,
              )),
      label: item.label,
    );
  }
}

class _KayleeBottomBarIcon extends StatelessWidget {
  final String icon;
  final Color color;
  final String? package;

  const _KayleeBottomBarIcon({
    Key? key,
    required this.icon,
    this.color = ColorsRes.hintText,
    this.package,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.px5),
      child: ImageIcon(
        AssetImage(icon, package: package),
        color: color,
      ),
    );
  }
}

class KayleeBottomBarIconData {
  final Widget? child;
  final String? path;
  final String? package;
  final Color? color;

  KayleeBottomBarIconData({this.child, this.path, this.package, this.color})
      : assert(child != null || path != null);
}

class KayleeBottomBarItem {
  final String label;
  final KayleeBottomBarIconData icon;
  final KayleeBottomBarIconData? activeIcon;

  KayleeBottomBarItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}
