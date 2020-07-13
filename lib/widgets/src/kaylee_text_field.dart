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

  /// [fieldHeight] chiều cao của text field
  /// khi set [fieldHeight], để text field expand với chiều cao [fieldHeight], thì [expands] phải set = true
  factory KayleeTextField.normal(
          {String title,
          String hint,
          double fieldHeight,
          FocusNode focusNode,
          FocusNode nextFocusNode,
          TextEditingController controller,
          TextInputAction textInputAction,
          TextInputType textInputType,
          String error,
          EdgeInsets contentPadding,
          bool expands,
          TextAlign textAlign}) =>
      KayleeTextField(
        title: title,
        textInput: NormalInputField(
          textInputAction: textInputAction,
          focusNode: focusNode,
          nextFocusNode: nextFocusNode,
          controller: controller,
          error: error,
          hint: hint,
          textInputType: textInputType,
          fieldHeight: fieldHeight,
          contentPadding: contentPadding,
          expands: expands,
          textAlign: textAlign,
        ),
      );

  factory KayleeTextField.unitSelection({
    String title,
    String hint,
    FocusNode focusNode,
    FocusNode nextFocusNode,
    TextEditingController controller,
    TextInputAction textInputAction,
    String error,
  }) =>
      KayleeTextField(
        title: title,
        textInput: UnitInputField(
          hint: hint,
          error: error,
          textInputAction: textInputAction,
        ),
      );

  factory KayleeTextField.multiLine({
    String title,
    String hint,
    double fieldHeight = Dimens.px48,
    FocusNode focusNode,
    FocusNode nextFocusNode,
    TextEditingController controller,
    TextInputAction textInputAction,
    String error,
    EdgeInsets contentPadding =
        const EdgeInsets.symmetric(vertical: Dimens.px16),
  }) =>
      KayleeTextField.normal(
        title: title,
        textInputAction: textInputAction,
        focusNode: focusNode,
        nextFocusNode: nextFocusNode,
        controller: controller,
        error: error,
        hint: hint,
        fieldHeight: fieldHeight,
        contentPadding: contentPadding,
        expands: true,
        textInputType: TextInputType.multiline,
        textAlign: TextAlign.start,
      );

  factory KayleeTextField.selection(
          {String title,
          String content,
          String buttonText,
          String error,
          VoidCallback onPress}) =>
      KayleeTextField(
        title: title,
        textInput: SelectInputTextField(
          content: content,
          buttonText: buttonText,
          onPress: onPress,
          error: error,
        ),
      );

  factory KayleeTextField.phoneInput(
          {String title,
          String hint,
          FocusNode focusNode,
          FocusNode nextFocusNode,
          TextEditingController controller,
          TextInputAction textInputAction,
          String error}) =>
      KayleeTextField(
        title: title ?? Strings.soDienThoai,
        textInput: PhoneInputField(
          hint: hint ?? Strings.phoneLimitHint,
          textInputAction: textInputAction,
          focusNode: focusNode,
          nextFocusNode: nextFocusNode,
          controller: controller,
          error: error,
        ),
      );

  factory KayleeTextField.staticWidget({String title, String initText}) =>
      KayleeTextField(
        title: title,
        textInput: NormalInputField(
          initText: initText,
          isStaticTField: true,
        ),
      );

  factory KayleeTextField.picker({String title, String hint, String error}) =>
      KayleeTextField(
        title: title,
        textInput: PickerInputField(
          error: error,
          hint: hint,
        ),
      );

  factory KayleeTextField.price(
          {String title,
          String hint,
          String error,
          TextEditingController controller,
          TextInputAction textInputAction}) =>
      KayleeTextField(
        title: title,
        textInput: PriceInputField(
          error: error,
          hint: hint,
          controller: controller,
          textInputAction: textInputAction,
        ),
      );

  factory KayleeTextField.password({
    String title,
    String hint,
    TextEditingController controller,
    TextInputAction textInputAction,
    FocusNode focusNode,
    FocusNode nextFocusNode,
    String error,
  }) =>
      KayleeTextField(
        title: title ?? Strings.matKhau,
        textInput: NormalInputField(
          controller: controller,
          hint: hint ?? '',
          textInputAction: textInputAction,
          textInputType: TextInputType.visiblePassword,
          focusNode: focusNode,
          nextFocusNode: nextFocusNode,
          error: error,
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
            child: KayleeText.normal16W500(title),
          ),
        if (textInput.isNotNull) textInput,
      ],
    );
  }
}

class PriceInputField extends StatefulWidget {
  final String hint;
  final String error;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  PriceInputField(
      {this.error, this.controller, this.hint, this.textInputAction});

  @override
  _PriceInputFieldState createState() => _PriceInputFieldState();
}

class _PriceInputFieldState extends BaseState<PriceInputField> {
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
    return _ErrorText(
      child: TextFieldBorderWrapper(
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: TextField(
                keyboardType: TextInputType.number,
                textInputAction: widget.textInputAction,
                style: TextStyles.normal16W400,
                maxLines: 1,
                minLines: 1,
                controller: widget.controller,
                onSubmitted: (value) {
                  if (widget.textInputAction == TextInputAction.next) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: TextStyles.hint16W400),
              ),
            )),
            Container(
              width: Dimens.px1,
              margin: const EdgeInsets.symmetric(vertical: Dimens.px4),
              color: ColorsRes.textFieldBorder,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px12),
              child: KayleeText.normal16W400(Strings.vnd),
            )
          ],
        ),
      ),
      error: widget.error,
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

class PickerInputField extends StatefulWidget {
  final String error;
  final String hint;

  PickerInputField({
    this.hint,
    this.error,
  });

  @override
  _PickerInputFieldState createState() => _PickerInputFieldState();
}

class _PickerInputFieldState extends BaseState<PickerInputField> {
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
  final double fieldHeight;
  final EdgeInsets contentPadding;
  final TextAlign textAlign;
  final bool expands;

  NormalInputField(
      {this.hint,
      this.initText,
      this.error,
      this.focusNode,
      this.controller,
      this.nextFocusNode,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text,
      this.isStaticTField = false,
      this.fieldHeight,
      this.contentPadding,
      this.textAlign,
      this.expands});

  @override
  _NormalInputFieldState createState() => _NormalInputFieldState();
}

class _NormalInputFieldState extends BaseState<NormalInputField> {
  bool showPass = false;
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
    return _ErrorText(
      child: TextFieldBorderWrapper(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
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
                        if (widget.nextFocusNode.isNotNull) {
                          widget.nextFocusNode.requestFocus();
                        } else
                          FocusScope.of(context).nextFocus();
                      }
                    },
                    autofocus: false,
                    obscureText: isPassTField ? !showPass : false,
                    textAlign: widget.textAlign ?? TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    expands: widget.expands ?? false,
                    maxLines: widget.expands ?? false ? null : 1,
                    minLines: widget.expands ?? false ? null : 1,
                    style: TextStyles.normal16W400,
                    decoration: InputDecoration(
                        enabled: !widget.isStaticTField,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: widget.hint,
                        contentPadding: widget.contentPadding ??
                            const EdgeInsets.only(bottom: Dimens.px4),
                        hintStyle: TextStyles.hint16W400),
                  ),
                ),
                if (isPassTField)
                  Padding(
                    padding: const EdgeInsets.only(left: Dimens.px16),
                    child: GestureDetector(
                        child: Icon(
                          !showPass ? Icons.visibility_off : Icons.visibility,
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
          fieldHeight: widget.fieldHeight,
          bgColor: widget.isStaticTField ? Colors.transparent : null,
          showFocusBorder: !widget.error.isNullOrEmpty),
      error: widget.error,
    );
  }
}

class PhoneInputField extends StatefulWidget {
  final String initText;
  final String hint;
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
      this.initText,
      this.hint});

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
    return _ErrorText(
      child: TextFieldBorderWrapper(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: Dimens.px10, right: Dimens.px13),
              child: const Text('+84'),
            ),
            Container(
                color: ColorsRes.textFieldBorder,
                width: Dimens.px1,
                margin:
                    const EdgeInsets.only(top: Dimens.px4, bottom: Dimens.px2)),
            Expanded(
              child: TextField(
                focusNode: widget.focusNode,
                controller:
                    widget.isStaticTField ? tfController : widget.controller,
                keyboardType: TextInputType.phone,
                maxLengthEnforced: true,
                enabled: !widget.isStaticTField,
                maxLength: 11,
                buildCounter: (BuildContext c,
                    {int currentLength, bool isFocused, int maxLength}) {
                  return null;
                },
                textInputAction: widget.textInputAction,
                onSubmitted: (_) {
                  if (widget.textInputAction == TextInputAction.next) {
                    if (widget.nextFocusNode.isNotNull) {
                      widget.nextFocusNode.requestFocus();
                    } else
                      FocusScope.of(context).nextFocus();
                  }
                },
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: widget.hint,
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
      error: widget.error,
    );
  }
}

class WebsiteInputField extends StatefulWidget {
  final String error;
  final TextEditingController websiteTfController;
  final TextEditingController domainTfController;
  final FocusNode websiteFocus;
  final FocusNode domainFocus;
  final TextInputAction textInputAction;

  WebsiteInputField({this.error,
    this.websiteFocus,
    this.domainFocus,
    this.websiteTfController,
    this.domainTfController,
    this.textInputAction});

  @override
  _WebsiteInputFieldState createState() => _WebsiteInputFieldState();
}

class _WebsiteInputFieldState extends BaseState<WebsiteInputField> {
  final inputDecoration = InputDecoration(
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.only(
          left: Dimens.px12, right: Dimens.px12, bottom: Dimens.px4),
      hintStyle: TextStyles.hint16W400);

  @override
  void dispose() {
    widget.domainTfController?.dispose();
    widget.websiteTfController?.dispose();
    widget.websiteFocus?.dispose();
    widget.domainFocus?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ErrorText(
      child: TextFieldBorderWrapper(
        Row(
          children: [
            Expanded(
              flex: (205 * 10 / 343).round(),
              child: FractionallySizedBox(
                child: TextField(
                  keyboardType: TextInputType.url,
                  style: TextStyles.normal16W400,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration.copyWith(
                    hintText: Strings.websiteHint,
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).nextFocus();
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: Dimens.px4),
              width: Dimens.px1,
              color: ColorsRes.textFieldBorder,
            ),
            Expanded(
              flex: (137 * 10 / 343).round(),
              child: FractionallySizedBox(
                child: TextField(
                  keyboardType: TextInputType.url,
                  textInputAction: widget.textInputAction,
                  style: TextStyles.normal16W400,
                  decoration: inputDecoration.copyWith(
                    hintText: Strings.domainHint,
                  ),
                  onSubmitted: (value) {
                    if (widget.textInputAction == TextInputAction.next) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        showFocusBorder: !widget.error.isNullOrEmpty,
      ),
      error: widget.error,
    );
  }
}

class SelectInputTextField extends StatefulWidget {
  final String error;
  final String content;
  final String buttonText;
  final VoidCallback onPress;

  SelectInputTextField(
      {this.error, this.content, this.onPress, this.buttonText});

  @override
  _SelectInputTextFieldState createState() => _SelectInputTextFieldState();
}

class _SelectInputTextFieldState extends BaseState<SelectInputTextField> {
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
    return _ErrorText(
      child: TextFieldBorderWrapper(Padding(
        padding: const EdgeInsets.only(
            left: Dimens.px16,
            right: Dimens.px4,
            bottom: Dimens.px4,
            top: Dimens.px4),
        child: Row(
          children: [
            Expanded(
                child: KayleeText.normal16W400(
                  widget.content ?? '',
                  maxLines: 1,
                )),
            KayleeFlatButton.withTextField(
              title: widget.buttonText,
              onPress: widget.onPress,
            )
          ],
        ),
      )),
      error: widget.error,
    );
  }
}

class UnitInputField extends StatefulWidget {
  final String hint;
  final String error;
  final TextInputAction textInputAction;

  UnitInputField({this.hint, this.error, this.textInputAction});

  @override
  _UnitInputFieldState createState() => _UnitInputFieldState();
}

class _UnitInputFieldState extends BaseState<UnitInputField> {
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
    return _ErrorText(
      child: TextFieldBorderWrapper(Row(
        children: [
          Expanded(
            flex: (2510 / 343).round(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: TextField(
                style: TextStyles.normal16W400,
                keyboardType: TextInputType.number,
                textInputAction: widget.textInputAction,
                onSubmitted: (value) {
                  if (widget.textInputAction == TextInputAction.next) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: TextStyles.hint16W400),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: Dimens.px4),
            width: Dimens.px1,
            color: ColorsRes.textFieldBorder,
          ),
          Expanded(
            flex: (910 / 343).round(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KayleeText.normal16W400('%'),
                  Image.asset(
                    Images.ic_down,
                    height: Dimens.px16,
                    width: Dimens.px16,
                  )
                ],
              ),
            ),
          )
        ],
      )),
      error: widget.error,
    );
  }
}

class _ErrorText extends StatelessWidget {
  final String error;
  final Widget child;

  _ErrorText({this.child, this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (child.isNotNull) child,
        if (!error.isNullOrEmpty)
          Container(
            margin: const EdgeInsets.only(top: Dimens.px4),
            alignment: Alignment.centerRight,
            child: KayleeText.error12W400(
              error,
              textAlign: TextAlign.end,
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
  final double fieldHeight;

  TextFieldBorderWrapper(this.child,
      {this.showFocusBorder, this.bgColor, this.fieldHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fieldHeight ?? Dimens.px48,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: BorderRadius.circular(Dimens.px5),
          border: Border.all(
              width: (showFocusBorder ?? false) ? Dimens.px2 : Dimens.px1,
              color: (showFocusBorder ?? false)
                  ? ColorsRes.errorBorder
                  : ColorsRes.textFieldBorder)),
      child: child,
    );
  }
}
