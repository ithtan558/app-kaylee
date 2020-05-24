import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/images.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeTextField extends StatelessWidget {
  final String title;
  final Widget textInput;

  KayleeTextField({this.title, this.textInput});

  factory KayleeTextField.staticWidget({String title, String initText}) =>
      KayleeTextField(
        title: title,
        textInput: NormalInputField(
          initText: initText,
          isStaticTField: true,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!title.isNullOrEmpty)
          Container(
            margin: EdgeInsets.only(bottom: Dimens.px8),
            child: Text(
              title,
              style: ScreenUtils.textTheme(context).bodyText2.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        if (textInput.isNotNull) textInput,
      ],
    );
  }
}

class SearchInputField extends StatefulWidget {
  final String hint;

  SearchInputField({this.hint});

  @override
  _SearchInputFieldState createState() => new _SearchInputFieldState();
}

class _SearchInputFieldState extends BaseState<SearchInputField> {
  final tfController = TextEditingController();
  bool closeIsShowed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldBorderWrapper(
      TextField(
        textInputAction: TextInputAction.search,
        controller: tfController,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (text) {
          if (text.isNotEmpty && !closeIsShowed) {
            setState(() {
              closeIsShowed = !closeIsShowed;
            });
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: Dimens.px16, bottom: Dimens.px14, left: Dimens.px16),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            hintText: widget.hint ?? '',
            hintStyle: TextStyles.hint16W400,
            suffixIcon: GestureDetector(
              onTap: () {
                if (closeIsShowed) {
                  setState(() {
                    tfController.text = '';
                    closeIsShowed = !closeIsShowed;
                  });
                }
              },
              child: Icon(
                !closeIsShowed ? Icons.search : Icons.close,
                color: ColorsRes.hintText,
              ),
            )),
      ),
    );
  }
}

class ButtonInputField extends StatefulWidget {
  final String hint;
  final String initText;
  final String buttonText;
  final Function() onTap;

  ButtonInputField({this.hint, this.initText, this.onTap, this.buttonText});

  @override
  _ButtonInputFieldState createState() => new _ButtonInputFieldState();
}

class _ButtonInputFieldState extends BaseState<ButtonInputField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldBorderWrapper(Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: Dimens.px16, right: Dimens.px14),
            child: KayleeText(
              widget.initText ?? '',
              maxLines: 1,
              style: TextStyles.normal16W400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: Dimens.px4,
          ),
          child: KayleeFlatButton(
            title: widget.buttonText,
            onPress: widget.onTap,
          ),
        )
      ],
    ));
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
        TextFieldBorderWrapper(
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _tfController,
                      enabled: false,
                      onTap: () {},
                      decoration: InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: widget.hint,
                          contentPadding: const EdgeInsets.only(
                            bottom: Dimens.px4,
                            left: Dimens.px16,
                          ),
                          hintStyle: TextStyles.hint16W400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.px16,
                    ),
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
            child: KayleeText(
              widget.error,
              textAlign: TextAlign.end,
              style: TextStyles.error12W400,
              overflow: TextOverflow.visible,
            ),
          )
      ],
    );
  }
}

class NormalInputField extends StatefulWidget {
  final String error;
  final String hint;
  final String initText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool isStaticTField;

  NormalInputField(
      {this.hint,
      this.initText,
      this.error,
      this.focusNode,
      this.controller,
      this.nextFocusNode,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text,
      this.isStaticTField = false});

  @override
  _NormalInputFieldState createState() => _NormalInputFieldState();
}

class _NormalInputFieldState extends BaseState<NormalInputField> {
  bool showPass = true;
  TextEditingController tfController;

  @override
  void initState() {
    super.initState();
    if (widget.isStaticTField) {
      tfController = TextEditingController(text: widget.initText);
    }
  }

  @override
  void dispose() {
    tfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPassTField = widget.textInputType == TextInputType.visiblePassword;
    return Column(
      children: <Widget>[
        TextFieldBorderWrapper(
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      focusNode: widget.focusNode,
                      controller: widget.isStaticTField
                          ? tfController
                          : widget.controller,
                      keyboardType: widget.textInputType,
                      textInputAction: widget.textInputAction,
                      enabled: !widget.isStaticTField,
                      onSubmitted: (_) {
                        if (widget.textInputAction == TextInputAction.next) {
                          widget.nextFocusNode?.requestFocus();
                        }
                      },
                      obscureText: isPassTField ? showPass : false,
                      decoration: InputDecoration(
                          enabled: !widget.isStaticTField,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: widget.hint,
                          contentPadding:
                              const EdgeInsets.only(bottom: Dimens.px4),
                          hintStyle: TextStyles.hint16W400),
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
            bgColor: widget.isStaticTField ? Colors.transparent : null,
            showFocusBorder: !widget.error.isNullOrEmpty),
        if (!widget.error.isNullOrEmpty)
          Container(
            margin: const EdgeInsets.only(top: Dimens.px4),
            alignment: Alignment.centerRight,
            child: KayleeText(
              widget.error,
              textAlign: TextAlign.end,
              style: TextStyles.error12W400,
              overflow: TextOverflow.visible,
            ),
          )
      ],
    );
  }
}

class PhoneInputField extends StatefulWidget {
  final String initText;
  final String error;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final bool isStaticTField;

  factory PhoneInputField.static({String initText}) => PhoneInputField(
        initText: initText,
        isStaticTField: true,
      );

  PhoneInputField(
      {this.error,
      this.focusNode,
      this.controller,
      this.nextFocusNode,
      this.textInputAction = TextInputAction.done,
      this.isStaticTField = false,
      this.initText});

  @override
  _PhoneInputFieldState createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  TextEditingController tfController;

  @override
  void initState() {
    super.initState();
    if (widget.isStaticTField) {
      tfController = TextEditingController(text: widget.initText);
    }
  }

  @override
  void dispose() {
    tfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = ScreenUtils.textTheme(context);
    return Column(
      children: <Widget>[
        TextFieldBorderWrapper(
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: Dimens.px10, right: Dimens.px13),
                child: Text('+84'),
              ),
              Container(
                  color: ColorsRes.textFieldBorder,
                  width: Dimens.px1,
                  margin: const EdgeInsets.only(
                      top: Dimens.px4, bottom: Dimens.px2)),
              Expanded(
                child: TextField(
                  focusNode: widget.focusNode,
                  controller:
                      widget.isStaticTField ? tfController : widget.controller,
                  keyboardType: TextInputType.phone,
                  maxLengthEnforced: true,
                  enabled: !widget.isStaticTField,
                  maxLength: 10,
                  buildCounter: (BuildContext c,
                      {int currentLength, bool isFocused, int maxLength}) {
                    return null;
                  },
                  textInputAction: widget.textInputAction,
                  onSubmitted: (_) {
                    if (widget.textInputAction == TextInputAction.next) {
                      widget.nextFocusNode?.requestFocus();
                    }
                  },
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: Strings.phoneLimitHint,
                      contentPadding: const EdgeInsets.only(
                          left: Dimens.px14,
                          right: Dimens.px16,
                          bottom: Dimens.px4),
                      hintStyle: TextStyles.hint16W400),
                ),
              )
            ],
          ),
          bgColor: widget.isStaticTField ? Colors.transparent : null,
        ),
        if (!widget.error.isNullOrEmpty)
          Container(
            margin: const EdgeInsets.only(top: Dimens.px4),
            alignment: Alignment.centerRight,
            child: KayleeText(
              widget.error,
              textAlign: TextAlign.end,
              style: TextStyles.error12W400,
              overflow: TextOverflow.visible,
            ),
          )
      ],
    );
  }
}

class TextFieldBorderWrapper extends StatelessWidget {
  final Widget child;
  final bool showFocusBorder;
  final Color bgColor;

  TextFieldBorderWrapper(this.child, {this.showFocusBorder, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px48,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
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
