import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BuildContext? dialogContext;

Future<T?> showKayleeBottomSheet<T>(BuildContext context,
    {required ScrollableWidgetBuilder builder,
    double maxChildSize = 1,
    bool expand = true,
    double initialChildSize = 0.5,
    double minChildSize = 0.25}) {
  final maxSize = maxChildSize;
  final initSize = initialChildSize;
  final minSize = minChildSize;
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
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 200),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              DraggableScrollableSheet(
                maxChildSize: maxSize,
                expand: expand,
                initialChildSize: initSize,
                minChildSize: minSize,
                builder: (c, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimens.px5),
                          topRight: Radius.circular(Dimens.px5)),
                      boxShadow: [
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
                            width: context.scaleWidth(Dimens.px37),
                            height: Dimens.px5,
                            margin: const EdgeInsets.symmetric(
                                vertical: Dimens.px16),
                            decoration: BoxDecoration(
                                color: ColorsRes.textFieldBorder,
                                borderRadius:
                                    BorderRadius.circular(Dimens.px3))),
                        Expanded(
                          child: builder(context, scrollController),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
      barrierColor: ColorsRes.dialogDimBg);
}

Future<void> showKayleeDialog({
  required BuildContext context,
  bool barrierDismissible = true,
  bool showFullScreen = false,
  bool showShadow = false,
  BorderRadius? borderRadius,
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: Dimens.px24),
  Widget? child,
  ValueSetter? onDismiss,
}) {
  return showGeneralDialog(
          context: context,
          barrierLabel: '',
          pageBuilder: (c, anim1, anim2) {
            final c = Container(
              margin: margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  if (showShadow)
                    const BoxShadow(
                        color: ColorsRes.shadow,
                        offset: Offset(0, Dimens.px10),
                        blurRadius: Dimens.px20,
                        spreadRadius: 0)
                ],
              ),
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius:
                    borderRadius ?? BorderRadius.circular(Dimens.px10),
                color: Colors.white,
                child: child ?? Container(),
              ),
            );
            return SafeArea(
              top: true,
              bottom: true,
              child:
                  showFullScreen ? c : Center(child: IntrinsicHeight(child: c)),
            );
          },
          barrierColor: ColorsRes.dialogDimBg,
          barrierDismissible: barrierDismissible,
          transitionDuration: const Duration(milliseconds: 200))
      .then((value) {
    onDismiss?.call(value);
  });
}

Future showKayleeAlertDialog(
    {required BuildContext context,
    KayleeAlertDialogView? view,
    VoidCallback? onDismiss,
    RouteSettings? routeSettings}) {
  return showCupertinoDialog(
          context: context,
          builder: (c) {
            dialogContext = c;
            return view ?? Container();
          },
          routeSettings: routeSettings)
      .then((value) {
    dialogContext = null;
    onDismiss?.call();
    return value;
  });
}

///show cupertino dialog với [message], chỉ có 1 action 'Đồng ý'
Future showKayleeAlertMessageYesDialog(
    {required BuildContext context,
    Message? message,
    VoidCallback? onPressed,
    VoidCallback? onDismiss}) {
  return showKayleeAlertDialog(
      context: context,
      view: KayleeAlertDialogView.message(
        message: message,
        actions: [KayleeAlertDialogAction.dongY(onPressed: onPressed)],
      ),
      onDismiss: onDismiss);
}

///show cupertino dialog với [error], chỉ có 1 action 'Đồng ý'
Future showKayleeAlertErrorYesDialog(
    {required BuildContext context,
    Error? error,
    VoidCallback? onPressed,
    VoidCallback? onDismiss}) {
  return showKayleeAlertDialog(
      context: context,
      view: KayleeAlertDialogView.error(
        error: error,
        actions: [KayleeAlertDialogAction.dongY(onPressed: onPressed)],
      ),
      onDismiss: onDismiss);
}

///view cupertino dialog để hiện thị trong [showKayleeAlertDialog]
class KayleeAlertDialogView extends StatelessWidget {
  final String? title;
  final String? content;
  final Widget? contentWidget;
  final List<KayleeAlertDialogAction>? actions;
  final bool allowBackPress;

  ///show cupertino dialog với [error] truyền vào
  factory KayleeAlertDialogView.error(
          {Error? error,
          List<KayleeAlertDialogAction>? actions,
          bool allowBackPress = true}) =>
      KayleeAlertDialogView(
        title: error?.title,
        content: error?.message,
        actions: actions,
        allowBackPress: allowBackPress,
      );

  ///show cupertino dialog với [message] truyền vào
  factory KayleeAlertDialogView.message(
          {Message? message,
          List<KayleeAlertDialogAction>? actions,
          bool allowBackPress = true}) =>
      KayleeAlertDialogView(
        title: message?.title,
        content: message?.content,
        actions: actions,
        allowBackPress: allowBackPress,
      );

  const KayleeAlertDialogView(
      {Key? key,
      this.title,
      this.content,
      this.actions,
      this.contentWidget,
      this.allowBackPress = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return allowBackPress;
      },
      child: CupertinoAlertDialog(
        title: title != null ? Text(title!) : null,
        content: contentWidget ??
            (content != null
                ? Padding(
                    padding: const EdgeInsets.only(top: Dimens.px3),
                    child: Text(content!),
                  )
                : null),
        actions: actions ?? [],
      ),
    );
  }
}

///action button trong [KayleeAlertDialogAction]
class KayleeAlertDialogAction extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isDefaultAction;

  factory KayleeAlertDialogAction.huy({VoidCallback? onPressed}) =>
      KayleeAlertDialogAction(
        title: StringsRes.huy,
        onPressed: onPressed,
      );

  factory KayleeAlertDialogAction.dongY(
          {VoidCallback? onPressed, bool isDefaultAction = false}) =>
      KayleeAlertDialogAction(
        title: StringsRes.dongY,
        onPressed: onPressed,
        isDefaultAction: isDefaultAction,
      );

  const KayleeAlertDialogAction(
      {Key? key,
      required this.title,
      this.onPressed,
      this.isDefaultAction = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      child: Text(title),
      isDefaultAction: isDefaultAction,
      onPressed: () {
        onPressed?.call();
      },
    );
  }
}

///vd: show date time picker
///[onDismiss] trả callback khi dialog dismiss hoặc user click 'Huỷ'
Future showPickerPopup(
    {required BuildContext context,
    required WidgetBuilder builder,
    VoidCallback? onDone,
    VoidCallback? onDismiss}) {
  final screenHeight = context.screenSize.height;
  return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Material(
          child: Container(
            height: screenHeight * 258 / 667,
            decoration: const BoxDecoration(
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
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.pop();
                            onDismiss?.call();
                          },
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: const Text(
                              StringsRes.huy,
                              style: TextStyle(
                                fontFamily: Fonts.sfProText,
                                package: anthPackage,
                                color: Color(0xff6092df),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.24,
                              ),
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            context.pop();
                            onDone?.call();
                          },
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: const Text(
                              StringsRes.hoanTat,
                              style: TextStyle(
                                fontFamily: Fonts.sfProText,
                                package: anthPackage,
                                color: Color(0xff6092df),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.24,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: screenHeight * 214 / 667,
                  color: Colors.white,
                  child: builder(context),
                ),
              ],
            ),
          ),
        );
      }).then((_) {
    onDismiss?.call();
  });
}

///change amount dialog
Future showKayleeAmountChangingDialog({
  required BuildContext context,
  required String title,
  required int initAmount,
  ValueSetter<int>? onAmountChange,
  VoidCallback? onRemoveItem,
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
    ),
  );
}

class _KayleeAmountChangingView extends StatefulWidget {
  final String title;
  final int initAmount;
  final ValueSetter<int>? onAmountChange;
  final VoidCallback? onRemoveItem;

  const _KayleeAmountChangingView({
    required this.title,
    required this.initAmount,
    this.onAmountChange,
    this.onRemoveItem,
  });

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
              Expanded(
                child: KayleeText.normal16W500(
                  widget.title,
                ),
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
                  btnIconColor: Colors.white,
                  btnBgColor: ColorsRes.button,
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
              child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: Dimens.px18),
                      ),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      )),
                  onPressed: () {
                    popScreen();
                  },
                  child: KayleeText.normal16W400(
                    StringsRes.huyBo,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )),
            ),
            Container(
              width: Dimens.px1,
              color: ColorsRes.divider,
            ),
            Expanded(
              child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: Dimens.px18),
                      ),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      )),
                  onPressed: () {
                    if (current <= 0) {
                      widget.onRemoveItem?.call();
                    } else {
                      if (
                          //chỉ khi amount trước và hiện tại khác nhau mới trả callback
                          current != widget.initAmount) {
                        widget.onAmountChange?.call(current);
                      }
                    }
                    popScreen();
                  },
                  child: KayleeText.hyper16W400(
                    current == 0
                        ? StringsRes.xoaKhoiGioHang
                        : StringsRes.xacNhan,
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

Future<dynamic> showKayleeDatePickerDialog(
    {required BuildContext context,
    DateTime? initialDateTime,
    VoidCallback? onDone,
    VoidCallback? onDismiss,
    required ValueChanged<DateTime> onDateTimeChanged,
    DateTime? maximumDate}) {
  return showPickerPopup(
    context: context,
    onDone: onDone,
    onDismiss: onDismiss,
    builder: (context) {
      return CupertinoDatePicker(
        maximumDate: maximumDate,
        mode: CupertinoDatePickerMode.date,
        initialDateTime: initialDateTime,
        onDateTimeChanged: onDateTimeChanged,
      );
    },
  );
}
