import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.px10),
        boxShadow: [
          BoxShadow(
              color: ColorsRes.shadow,
              offset: Offset(0, 1),
              blurRadius: Dimens.px5,
              spreadRadius: 0)
        ],
      ),
      child: SafeArea(
          top: true,
          child: Container(
            padding: const EdgeInsets.all(Dimens.px16),
            child: SizedBox(
              height: Dimens.px103,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.px10),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        context.user.getUserInfo()?.userInfo?.image ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: Dimens.px16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          KayleeText.normal26W700(
                            context.user.getUserInfo()?.userInfo?.name ?? '',
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: Dimens.px8),
                              child: KayleeText.normal16W400(
                                Strings.quanlyCuaHang,
                              ),
                            ),
                          ),
                          HyperLinkText(
                            text: Strings.suThongTin,
                            onTap: () {
                              context
                                  .push(PageIntent(screen: EditProfileScreen));
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
