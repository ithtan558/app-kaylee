import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

Future<T> showKayleeBottomSheet<T>(context,
    {@required ScrollableWidgetBuilder builder,
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
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  pop(PageIntent(context, null));
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: maxChildSize ?? 1,
              expand: expand,
              initialChildSize: initialChildSize ?? 0.5,
              minChildSize: minChildSize ?? 0.25,
              builder: (c, scrollController) {
                return Container(
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
            )
          ],
        );
      },
      barrierColor: ColorsRes.dialogDimBg);
}

Future<void> showKayleeGo2SettingDialog({
  @required BuildContext context,
  bool barrierDismissible = true,
}) {
  return showKayleeDialog(
      context: context,
      barrierDismissible: barrierDismissible,
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
                right: Dimens.px16, left: Dimens.px16, bottom: Dimens.px16),
            child: KayleeText.normal16W400(
              Strings.quyenTruyCapHinhAnhContent,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: Dimens.px16, left: Dimens.px16, bottom: Dimens.px16),
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
                    onPressed: () {
                      pop(PageIntent(context, null));
                      openAppSettings();
                    },
                    margin: const EdgeInsets.only(
                        left: Dimens.px8, right: Dimens.px16),
                  ),
                )
              ],
            ),
          )
        ],
      ));
}

Future<void> showKayleeDialog(
    {@required BuildContext context,
    bool barrierDismissible = true,
    bool showFullScreen = false,
    bool showShadow = false,
    BorderRadius borderRadius,
    EdgeInsets margin,
    Widget child}) {
  return showGeneralDialog(
      context: context,
      barrierLabel: '',
      pageBuilder: (c, anim1, anim2) {
        final c = Container(
          margin: margin ?? const EdgeInsets.symmetric(horizontal: Dimens.px24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                    color: ColorsRes.shadow,
                    offset: Offset(0, Dimens.px10),
                    blurRadius: Dimens.px20,
                    spreadRadius: 0)
            ],
          ),
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: borderRadius ?? BorderRadius.circular(Dimens.px10),
            color: Colors.white,
            child: child ?? Container(),
          ),
        );
        return SafeArea(
          top: true,
          bottom: true,
          child: showFullScreen ? c : Center(child: IntrinsicHeight(child: c)),
        );
      },
      barrierColor: ColorsRes.dialogDimBg,
      barrierDismissible: barrierDismissible,
      transitionDuration: Duration(milliseconds: 200));
}

Future showKayleeAlertDialog({@required BuildContext context,
  String title,
  String content,
  List<KayleeAlertDialogAction> actions}) {
  return showCupertinoDialog(
      context: context,
      builder: (c) {
        return CupertinoAlertDialog(
          title: Text(
            title ?? '',
          ),
          content: Text(
            content ?? '',
          ),
          actions: actions ?? [],
        );
      });
}

class KayleeAlertDialogAction extends StatelessWidget {
  final String title;
  final void Function(BuildContext context) onPressed;
  final bool isDefaultAction;

  factory KayleeAlertDialogAction.huy({bool Function() onPressed}) =>
      KayleeAlertDialogAction(
        title: Strings.huy,
        onPressed: (context) {
          if (onPressed.isNotNull && onPressed() ?? false) {
            pop(PageIntent(context, null));
          }
        },
      );

  factory KayleeAlertDialogAction.dongY(
      {bool Function() onPressed, bool isDefaultAction = false}) =>
      KayleeAlertDialogAction(
        title: Strings.dongY,
        onPressed: (context) {
          if (onPressed.isNotNull && onPressed() ?? false) {
            pop(PageIntent(context, null));
          }
        },
        isDefaultAction: isDefaultAction,
      );

  KayleeAlertDialogAction(
      {@required this.title, this.onPressed, this.isDefaultAction = false});

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      child: Text(
        title ?? '',
      ),
      isDefaultAction: isDefaultAction ?? false,
      onPressed: () {
        if (onPressed.isNotNull) {
          onPressed(context);
        }
      },
    );
  }
}

///vd: show date time picker
Future showPickerPopup(
    {@required BuildContext context, @required WidgetBuilder builder}) {
  final screenHeight = ScreenUtils
      .screenSize(context)
      .height;
  return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: screenHeight * 258 / 667,
          decoration: BoxDecoration(
            color: ColorsRes.dialogNavigate,
            boxShadow: [
              BoxShadow(
                  color: ColorsRes.shadow,
                  offset: Offset(0, -0.5),
                  blurRadius: 0,
                  spreadRadius: 0)
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                  height: screenHeight * Dimens.px44 / 667,
                  alignment: Alignment.centerRight),
              Container(
                height: screenHeight * 214 / 667,
                child: builder(context),
              ),
            ],
          ),
        );
      });
}

///change amount dialog
Future showKayleeAmountChangingDialog({
  @required BuildContext context,
  String title,
  int initAmount,
  ValueSetter<int> onAmountChange,
  VoidCallback onRemoveItem,
}) {
  return showKayleeDialog(
      context: context,
      borderRadius: BorderRadius.circular(Dimens.px5),
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: _KayleeAmountChangingView(
        title: title,
        initAmount: initAmount,
        onAmountChange: onAmountChange,
        onRemoveItem: onRemoveItem,
      ));
}

class _KayleeAmountChangingView extends StatefulWidget {
  final String title;
  final int initAmount;
  final ValueSetter<int> onAmountChange;
  final VoidCallback onRemoveItem;

  _KayleeAmountChangingView(
      {this.title, this.initAmount, this.onAmountChange, this.onRemoveItem});

  @override
  _KayleeAmountChangingViewState createState() =>
      _KayleeAmountChangingViewState();
}

class _KayleeAmountChangingViewState
    extends BaseState<_KayleeAmountChangingView> {
  int current = 1;

  @override
  void initState() {
    super.initState();
    current = widget.initAmount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: Dimens.px16,
              right: Dimens.px24,
              top: Dimens.px27,
              bottom: Dimens.px32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KayleeText.normal16W500(
                widget.title,
              ),
              Padding(
                padding: const EdgeInsets.only(left: Dimens.px16),
                child: KayleeIncrAndDecrButtons(
                  initAmount: current,
                  amountMin: 0,
                  onAmountChange: (value) {
                    current = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          height: Dimens.px1,
          color: ColorsRes.divider,
        ),
        Row(
          children: [
            Expanded(
              child: FlatButton(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px18),
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  onPressed: () {
                    popScreen();
                  },
                  child: KayleeText.normal16W400(
                    Strings.huyBo,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              width: Dimens.px1,
              color: ColorsRes.divider,
            ),
            Expanded(
              child: FlatButton(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px18),
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  onPressed: () {
                    if (current <= 0) {
                      if (widget.onRemoveItem.isNotNull) {
                        widget.onRemoveItem();
                      }
                    } else {
                      if (widget.onAmountChange.isNotNull) {
                        widget.onAmountChange(current);
                      }
                    }
                    popScreen();
                  },
                  child: KayleeText.hyper16W400(
                    current == 0 ? Strings.xoaKhoiGioHang : Strings.xacNhan,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        )
      ],
    );
  }
}
