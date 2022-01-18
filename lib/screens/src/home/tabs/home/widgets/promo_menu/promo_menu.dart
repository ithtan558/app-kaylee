import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';

class PromoMenu extends StatelessWidget {
  const PromoMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      height: Dimens.px80,
      child: Row(
        children: [
          _buildItem(
            icon: Images.icProdDaily,
            title: Strings.giaReMoiNgay,
            onTap: () {
              context.push(PageIntent(screen: DailyEventScreen));
            },
          ),
          const SizedBox(width: Dimens.px8),
          _buildItem(
            icon: Images.icProdSpecial,
            title: Strings.hangDocLa,
            onTap: () {
              context.push(PageIntent(screen: SpecialEventScreen));
            },
          ),
          const SizedBox(width: Dimens.px8),
          _buildItem(
            icon: Images.icProdHot,
            title: Strings.chuongTrinhHot,
            onTap: () {
              context.push(PageIntent(screen: HotEventScreen));
            },
          ),
          const SizedBox(width: Dimens.px8),
          _buildItem(
            icon: Images.icProdPro,
            title: Strings.salonProfessional,
            onTap: () {
              context.push(PageIntent(screen: SalonProfessionalScreen));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
      {required String icon,
      required String title,
      required VoidCallback onTap}) {
    return Expanded(
      child: Material(
        color: ColorsRes.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: ColorsRes.hyper,
            ),
            borderRadius: BorderRadius.circular(Dimens.px5)),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.px10),
            child: Column(
              children: [
                ImageIcon(
                  AssetImage(icon),
                  color: ColorsRes.hyper,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: KayleeText.hyper12W400(
                      title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
