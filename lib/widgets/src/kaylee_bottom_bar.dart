import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeBottomBar extends StatefulWidget {
  final void Function(int index)? onTapChanged;
  final PageController? pageController;

  KayleeBottomBar({this.onTapChanged, this.pageController});

  @override
  _KayleeBottomBarState createState() => new _KayleeBottomBarState();
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
          activeImage: Images.icHomeActive,
          inActiveImage: Images.icHomeInactive,
        ),
        _buildBtmBarItem(
          title: Strings.thuNgan,
          activeImage: Images.icCashierActive,
          inActiveImage: Images.icCashierInactive,
        ),
        _buildBtmBarItem(
          title: Strings.lichSuDh,
          activeImage: Images.icHistoryActive,
          inActiveImage: Images.icHistoryInactive,
        ),
        _buildBtmBarItem(
          title: Strings.taiKhoan,
          activeImage: Images.icAccountActive,
          inActiveImage: Images.icAccountInactive,
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
        if (index != selectedTab)
          setState(() {
            selectedTab = index;
            widget.onTapChanged?.call(selectedTab);
          });
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

  _buildBtmBarItem({
    required String title,
    required String inActiveImage,
    required String activeImage,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        inActiveImage,
        width: Dimens.px24,
        height: Dimens.px24,
      ),
      activeIcon: Image.asset(
        activeImage,
        width: Dimens.px24,
        height: Dimens.px24,
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: Dimens.px5),
        child: Text(title),
      ),
    );
  }
}
