import 'package:flutter/material.dart';
import 'package:anth_package/anth_package.dart';
import 'package:kaylee/res/colors_res.dart';
import 'package:kaylee/res/dimens.dart';
import 'package:kaylee/res/images.dart';
import 'package:kaylee/res/strings.dart';

class KayleeTextField extends StatelessWidget {
  final String title;
  final Widget textField;

  KayleeTextField({this.title, this.textField});

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
        if (textField.isNotNull)
          Container(
            child: textField,
            margin: EdgeInsets.only(top: Dimens.px8),
          ),
      ],
    );
  }
}

class NormalTextField extends StatefulWidget {
  final String error;
  final String hint;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  NormalTextField(
      {this.hint,
      this.error,
      this.focusNode,
      this.controller,
      this.nextFocusNode,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text});

  @override
  _NormalTextFieldState createState() => _NormalTextFieldState();
}

class _NormalTextFieldState extends BaseState<NormalTextField> {
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

class PhoneTextField extends StatelessWidget {
  final String error;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  PhoneTextField(
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

  KayLeeRoundedButton({this.width, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px48,
      width: width.isNotNull ? width : double.infinity,
      margin: EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: FlatButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        color: ColorsRes.button,
        child: Text(text ?? '',
            style:
                ScreenUtils.screenTheme(context).textTheme.bodyText2.copyWith(
                      color: Color(0xffffffff),
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
              //todo open SignUpScreen
//              push(PageIntent(context, screen));
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
