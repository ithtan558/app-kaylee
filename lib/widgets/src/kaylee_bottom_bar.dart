import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeBottomBar extends StatefulWidget {
  final void Function(int index) onTapChanged;
  final PageController pageController;

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
      selectedTab = widget.pageController.page.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildBtmBarItem(
          title: Strings.trangChu,
          activeImage: Images.ic_home_active,
          inActiveImage: Images.ic_home_inactive,
        ),
        _buildBtmBarItem(
          title: Strings.thuNgan,
          activeImage: Images.ic_cashier_active,
          inActiveImage: Images.ic_cashier_inactive,
        ),
        _buildBtmBarItem(
          title: Strings.lichSuDh,
          activeImage: Images.ic_history_active,
          inActiveImage: Images.ic_history_inactive,
        ),
        _buildBtmBarItem(
          title: Strings.taiKhoan,
          activeImage: Images.ic_account_active,
          inActiveImage: Images.ic_account_inactive,
        ),
      ],
      selectedLabelStyle: theme.textTheme.bodyText2.copyWith(
        fontSize: Dimens.px12,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: theme.textTheme.bodyText2.copyWith(
        fontSize: Dimens.px12,
      ),
      onTap: (index) {
        if (index != selectedTab)
          setState(() {
            selectedTab = index;
            if (widget.onTapChanged != null) {
              widget.onTapChanged(selectedTab);
            }
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
    String title,
    String inActiveImage,
    String activeImage,
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
