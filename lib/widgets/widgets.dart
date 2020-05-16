import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:anth_package/anth_package.dart';
import 'package:kaylee/res/colors_res.dart';
import 'package:kaylee/res/dimens.dart';
import 'package:kaylee/res/images.dart';
import 'package:kaylee/res/strings.dart';
import 'package:kaylee/screens/signup/signup_screen.dart';

class KayleeTextField extends StatelessWidget {
  final String title;
  final Widget textInput;

  KayleeTextField({this.title, this.textInput});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!title.isNullOrEmpty)
          Text(
            title,
            style:
                ScreenUtils.screenTheme(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
          ),
        if (textInput.isNotNull)
          Container(
            child: textInput,
            margin: EdgeInsets.only(top: Dimens.px8),
          ),
      ],
    );
  }
}

class SelectionInputField extends StatefulWidget {
  final String error;
  final String hint;

  SelectionInputField({
    this.hint,
    this.error,
  });

  @override
  _SelectionInputFieldState createState() => _SelectionInputFieldState();
}

class _SelectionInputFieldState extends BaseState<SelectionInputField> {
  final _tfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TextFieldBorderWrapper(
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _tfController,
                      style: theme.textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      enabled: false,
                      onTap: () {},
                      decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: widget.hint,
                          contentPadding:
                              const EdgeInsets.only(bottom: Dimens.px4),
                          hintStyle: theme.textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: Dimens.px16),
                    child: Image.asset(
                      Images.ic_down,
                      width: Dimens.px16,
                      height: Dimens.px16,
                    ),
                  )
                ],
              ),
            ),
            showFocusBorder: !widget.error.isNullOrEmpty),
        if (!widget.error.isNullOrEmpty)
          Container(
            margin: const EdgeInsets.only(top: Dimens.px4),
            alignment: Alignment.centerRight,
            child: Text(widget.error,
                style: theme.textTheme.bodyText2.copyWith(
                  color: Color(0xffcd2e2e),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                )),
          )
      ],
    );
  }
}

class NormalInputField extends StatefulWidget {
  final String error;
  final String hint;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  NormalInputField(
      {this.hint,
      this.error,
      this.focusNode,
      this.controller,
      this.nextFocusNode,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text});

  @override
  _NormalInputFieldState createState() => _NormalInputFieldState();
}

class _NormalInputFieldState extends BaseState<NormalInputField> {
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    final isPassTField = widget.textInputType == TextInputType.visiblePassword;
    return Column(
      children: <Widget>[
        _TextFieldBorderWrapper(
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      keyboardType: widget.textInputType,
                      textInputAction: widget.textInputAction,
                      onSubmitted: (_) {
                        if (widget.textInputAction == TextInputAction.next) {
                          widget.nextFocusNode?.requestFocus();
                        }
                      },
                      obscureText: isPassTField ? showPass : false,
                      style: theme.textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: widget.hint,
                          contentPadding:
                              const EdgeInsets.only(bottom: Dimens.px4),
                          hintStyle: theme.textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  if (isPassTField)
                    Padding(
                      padding: const EdgeInsets.only(left: Dimens.px16),
                      child: GestureDetector(
                          child: Icon(
                            !showPass ? Icons.visibility : Icons.visibility_off,
                            color: ColorsRes.hintText,
                          ),
                          onTap: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          }),
                    ),
                  if (!widget.error.isNullOrEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: Dimens.px16),
                      child: Image.asset(
                        Images.ic_error,
                        width: Dimens.px16,
                        height: Dimens.px16,
                      ),
                    )
                ],
              ),
            ),
            showFocusBorder: !widget.error.isNullOrEmpty),
        if (!widget.error.isNullOrEmpty)
          Container(
            margin: const EdgeInsets.only(top: Dimens.px4),
            alignment: Alignment.centerRight,
            child: Text(widget.error,
                style: theme.textTheme.bodyText2.copyWith(
                  color: Color(0xffcd2e2e),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                )),
          )
      ],
    );
  }
}

class PhoneInputField extends StatelessWidget {
  final String error;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  PhoneInputField(
      {this.error,
      this.focusNode,
      this.controller,
      this.nextFocusNode,
      this.textInputAction = TextInputAction.done});

  @override
  Widget build(BuildContext context) {
    final textTheme = ScreenUtils.screenTheme(context).textTheme;
    return Column(
      children: <Widget>[
        _TextFieldBorderWrapper(Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: Dimens.px10, right: Dimens.px13),
              child: Text("+84",
                  style: textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.w400,
                  )),
            ),
            Container(
                color: ColorsRes.textFieldBorder,
                width: Dimens.px1,
                margin:
                    const EdgeInsets.only(top: Dimens.px4, bottom: Dimens.px2)),
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                keyboardType: TextInputType.phone,
                maxLengthEnforced: true,
                maxLength: 10,
                buildCounter: (BuildContext c,
                    {int currentLength, bool isFocused, int maxLength}) {
                  return null;
                },
                textInputAction: textInputAction,
                onSubmitted: (_) {
                  if (textInputAction == TextInputAction.next) {
                    nextFocusNode?.requestFocus();
                  }
                },
                style: textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: Strings.phoneLimitHint,
                    contentPadding: const EdgeInsets.only(
                        left: Dimens.px14,
                        right: Dimens.px16,
                        bottom: Dimens.px4),
                    hintStyle: textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
              ),
            )
          ],
        )),
        if (!error.isNullOrEmpty)
          Container(
            margin: const EdgeInsets.only(top: Dimens.px4),
            alignment: Alignment.centerRight,
            child: Text(error,
                style: textTheme.bodyText2.copyWith(
                  color: Color(0xffcd2e2e),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                )),
          )
      ],
    );
  }
}

class _TextFieldBorderWrapper extends StatelessWidget {
  final Widget child;
  final bool showFocusBorder;

  _TextFieldBorderWrapper(this.child, {this.showFocusBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px48,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimens.px5),
          border: Border.all(
              width: (showFocusBorder ?? false) ? Dimens.px2 : Dimens.px1,
              color: (showFocusBorder ?? false)
                  ? ColorsRes.errorText
                  : ColorsRes.textFieldBorder)),
      child: child,
    );
  }
}

class KayLeeRoundedButton extends StatelessWidget {
  final double width;
  final String text;
  final void Function() onPressed;
  final EdgeInsets margin;

  KayLeeRoundedButton({this.width, this.text, this.onPressed, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px48,
      width: width.isNotNull ? width : double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: FlatButton(
        onPressed: onPressed,
        shape: const StadiumBorder(),
        color: ColorsRes.button,
        child: Text(text ?? '',
            style:
                ScreenUtils.screenTheme(context).textTheme.bodyText2.copyWith(
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                    )),
      ),
    );
  }
}

class Go2RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = ScreenUtils.screenTheme(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.chuaCoTK,
          style: textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: Dimens.px8),
          child: GestureDetector(
            onTap: () {
              push(PageIntent(context, SignUpScreen));
            },
            child: Container(
              color: Colors.transparent,
              child: Text(Strings.dangKy,
                  style: textTheme.bodyText2.copyWith(
                    color: ColorsRes.hyper,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class KayleeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final bool Function() onBack;
  final List<Widget> actions;

  KayleeAppBar({this.title, this.leading, this.onBack, this.actions});

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop;
    return AppBar(
      leading: canPop
          ? FlatButton(
              shape: CircleBorder(),
              child: Icon(
                CupertinoIcons.back,
                color: ColorsRes.hintText,
              ),
              onPressed: () {
                if (onBack == null || onBack()) {
                  pop(PageIntent(context, null));
                }
              },
            )
          : leading,
      automaticallyImplyLeading: false,
      title: Text(
        title?.toUpperCase() ?? '',
        style: ScreenUtils.screenTheme(context).textTheme.bodyText2.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      elevation: 0,
      brightness: Brightness.light,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class PolicyCheckBox extends StatefulWidget {
  @override
  _PolicyCheckBoxState createState() => _PolicyCheckBoxState();
}

class _PolicyCheckBoxState extends BaseState<PolicyCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = theme.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          child: Image.asset(
            isChecked ? Images.ic_checked : Images.ic_notcheck,
            width: Dimens.px24,
            height: Dimens.px24,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: Dimens.px10),
            child: Text.rich(TextSpan(
                text: 'Tôi đồng ý mọi',
                style:
                    textTheme.bodyText2.copyWith(fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                      text: ' điều khoản và quy định ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showSheet();
                        },
                      style: textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w400, color: ColorsRes.hyper)),
                  TextSpan(
                      text: 'khi sử dụng ứng dụng Kaylee',
                      style: textTheme.bodyText2
                          .copyWith(fontWeight: FontWeight.w400))
                ])),
          ),
        )
      ],
    );
  }

  void _showSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(Dimens.px5),
                topRight: const Radius.circular(Dimens.px5))),
        enableDrag: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (c) {
          return DraggableScrollableSheet(
            maxChildSize: 0.90,
            builder: (c, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    const BoxShadow(
                        color: Color(0x4c000000),
                        offset: Offset(0, 0),
                        blurRadius: 20,
                        spreadRadius: 0)
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                        width: 37,
                        height: 5,
                        margin:
                            const EdgeInsets.symmetric(vertical: Dimens.px16),
                        decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            borderRadius: BorderRadius.circular(3))),
                    Text(Strings.dieuKhoanVaDieuKien,
                        style: theme.textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Dimens.px16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.only(
                              left: Dimens.px16,
                              right: Dimens.px16,
                              bottom: Dimens.px16),
                          child: Text(
                            Strings.policyContent,
                            style: theme.textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        barrierColor: Color(0x7f313131));
  }
}
