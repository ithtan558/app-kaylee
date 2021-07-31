import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeBottomBar extends StatefulWidget {
  final void Function(int index)? onTapChanged;
  final PageController? pageController;

  const KayleeBottomBar({Key? key, this.onTapChanged, this.pageController})
      : super(key: key);

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
      items: [
        _buildBtmBarItem(
          title: Strings.trangChu,
          icon: Images.icHomeActive,
        ),
        _buildBtmBarItem(
          title: Strings.thuNgan,
          icon: Images.icCashierActive,
        ),
        _buildBtmBarItem(
          title: Strings.lichSuDh,
          icon: Images.icHistoryActive,
        ),
        _buildBtmBarItem(
          title: Strings.taiKhoan,
          icon: Images.icAccountActive,
        ),
      ],
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

  BottomNavigationBarItem _buildBtmBarItem({
    required String title,
    required String icon,
  }) {
    return BottomNavigationBarItem(
      icon: _buildIcon(icon: icon, color: ColorsRes.hintText),
      activeIcon: _buildIcon(icon: icon, color: ColorsRes.hyper),
      label: title,
    );
  }

  Widget _buildIcon({required String icon, required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.px5),
      child: ImageIcon(
        AssetImage(icon),
        color: color,
      ),
    );
  }
}
