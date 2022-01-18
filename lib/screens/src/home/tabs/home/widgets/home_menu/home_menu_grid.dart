import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/home_menu_item.dart';
import 'package:kaylee/utils/utils.dart';

class HomeMenuGrid extends StatefulWidget {
  const HomeMenuGrid({Key? key}) : super(key: key);

  @override
  State<HomeMenuGrid> createState() => _HomeMenuGridState();
}

class _HomeMenuGridState extends State<HomeMenuGrid> {
  late IndicatorController _indicatorController;
  late List<Widget> menuItems;

  UserInfo? get userInfo => context.user.getUserInfo().userInfo;
  final _itemPerPage = 8;

  @override
  void initState() {
    super.initState();
    menuItems = <Widget>[
      if (userInfo?.role != UserRole.employee) ...[
        HomeMenuItem(
          title: Strings.qlChiNhanh,
          icon: Images.icStore,
          onTap: () {
            context.push(PageIntent(screen: BrandListScreen));
          },
        ),
        HomeMenuItem(
          title: Strings.dsDichVu,
          icon: Images.icServiceList,
          onTap: () {
            context.push(PageIntent(screen: ServiceListScreen));
          },
        ),
        HomeMenuItem(
          title: Strings.dsSanPham,
          icon: Images.icProduct,
          onTap: () {
            context.push(PageIntent(screen: ProdListScreen));
          },
        ),
        HomeMenuItem(
          title: Strings.qlNhanVien,
          icon: Images.icPerson,
          onTap: () {
            context.push(PageIntent(screen: StaffListScreen));
          },
        ),
        HomeMenuItem(
          title: Strings.dsKhachHang,
          icon: Images.icUserList,
          onTap: () {
            context.push(PageIntent(screen: CustomerListScreen));
          },
        ),
        HomeMenuItem(
          title: Strings.dsLichHen,
          icon: Images.icBooking,
          onTap: () {
            context.push(PageIntent(screen: ReservationListScreen));
          },
        ),
        HomeMenuItem(
          title: Strings.hoaHongNv,
          icon: Images.icCommission,
          onTap: () {
            context.push(PageIntent(screen: CommissionListScreen));
          },
        ),
        HomeMenuItem(
          title: Strings.doanhThuBanHang,
          icon: Images.icRevenue,
          onTap: () {
            context.push(PageIntent(screen: RevenueScreen));
          },
        ),
        HomeMenuItem(
          title: Strings.kienThuc,
          icon: Images.icKnowledge,
          onTap: () {
            context.push(PageIntent(screen: KnowledgeScreen));
          },
        ),
      ]
    ];
    _indicatorController =
        IndicatorController(length: (menuItems.length / _itemPerPage).ceil());
  }

  @override
  Widget build(BuildContext context) {
    //76+16+76
    return Column(
      children: [
        SizedBox(
          height: Dimens.px76 + Dimens.px8 + Dimens.px76,
          child: PageView(
            children: List.generate((menuItems.length / _itemPerPage).ceil(),
                (index) => _buildPage(index)),
            onPageChanged: (value) {
              _indicatorController.jumpTo(index: value);
            },
          ),
        ),
        const SizedBox(
          height: Dimens.px12,
        ),
        Indicator(controller: _indicatorController),
      ],
    );
  }

  Widget _buildPage(int index) {
    final firstIndex = index * _itemPerPage;
    var lastIndex = firstIndex + _itemPerPage;
    lastIndex = lastIndex > menuItems.length ? menuItems.length : lastIndex;
    final items = menuItems.sublist(firstIndex, lastIndex);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: Dimens.px0,
        mainAxisSpacing: Dimens.px8,
        mainAxisExtent: Dimens.px76,
      ),
      itemBuilder: (context, index) {
        return items.elementAt(index);
      },
      itemCount: items.length,
    );
  }
}
