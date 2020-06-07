import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

Future<T> showKayleeBottomSheet<T>(
    context,
    {@required
        Widget Function(BuildContext context, ScrollController controller)
            builder,
    double maxChildSize = 1,
    bool expand = true,
    double initialChildSize = 0.5,
    double minChildSize = 0.25}) {
  return showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.px5),
              topRight: Radius.circular(Dimens.px5))),
      enableDrag: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (c) {
        return GestureDetector(
          onTap: () {
            pop(PageIntent(context, null));
          },
          child: Container(
            color: Colors.transparent,
            child: DraggableScrollableSheet(
              maxChildSize: maxChildSize ?? 1,
              expand: expand,
              initialChildSize: initialChildSize ?? 0.5,
              minChildSize: minChildSize ?? 0.25,
              builder: (c, scrollController) {
                return Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(Dimens.px5),
                        topRight: Radius.circular(Dimens.px5)),
                    boxShadow: const [
                      BoxShadow(
                          color: ColorsRes.shadow,
                          offset: Offset.zero,
                          blurRadius: Dimens.px20,
                          spreadRadius: 0)
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                          width: ScreenUtils.scaleWidth(context, Dimens.px37),
                          height: Dimens.px5,
                          margin:
                              const EdgeInsets.symmetric(vertical: Dimens.px16),
                          decoration: BoxDecoration(
                              color: ColorsRes.textFieldBorder,
                              borderRadius: BorderRadius.circular(Dimens.px3))),
                      Expanded(
                        child:
                            builder(context, scrollController) ?? Container(),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
      barrierColor: ColorsRes.dialogDimBg);
}

Future<void> showKayleeGo2SettingDialog({
  @required BuildContext context,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog(
      context: context,
      barrierLabel: '',
      pageBuilder: (c, anim1, anim2) {
        return Center(
          child: IntrinsicHeight(
            child: Container(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtils.scaleWidth(context, Dimens.px24)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimens.px10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.px16,
                      left: Dimens.px16,
                      bottom: Dimens.px16,
                      top: Dimens.px24,
                    ),
                    child: KayleeText.normal18W700(
                      Strings.quyenTruyCapHinhAnh,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: Dimens.px16,
                        left: Dimens.px16,
                        bottom: Dimens.px16),
                    child: KayleeText.normal16W400(
                      Strings.quyenTruyCapHinhAnhContent,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: Dimens.px16,
                        left: Dimens.px16,
                        bottom: Dimens.px16),
                    child: KayleeText.normal16W400(
                      Platform.isAndroid
                          ? Strings.androidStoragePermissionGuide
                          : Strings.iOsStoragePermissionGuide,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: Dimens.px1,
                    color: ColorsRes.divider,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                    child: Row(
                      children: [
                        Expanded(
                          child: KayLeeRoundedButton.button2(
                            text: Strings.huy,
                            onPressed: () {
                              pop(PageIntent(context, null));
                            },
                            margin: const EdgeInsets.only(
                                right: Dimens.px8, left: Dimens.px16),
                          ),
                        ),
                        Expanded(
                          child: KayLeeRoundedButton.normal(
                            text: Strings.caiDatNgay,
                            onPressed: () async {
                              pop(PageIntent(context, null));
                              final result = await openAppSettings();
                            },
                            margin: const EdgeInsets.only(
                                left: Dimens.px8, right: Dimens.px16),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      barrierColor: ColorsRes.dialogDimBg,
      barrierDismissible: barrierDismissible,
      transitionDuration: Duration(milliseconds: 200));
}
