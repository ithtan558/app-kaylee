import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KayleeTextField extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? textInput;

  const KayleeTextField(
      {Key? key, this.title, this.textInput, this.titleWidget})
      : super(key: key);

  factory KayleeTextField.withUnit({
    Key? key,
    String? title,
    String? hint,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    TextEditingController? controller,
    TextInputAction textInputAction = TextInputAction.done,
    TextInputType textInputType = TextInputType.text,
    String? error,
    TextAlign textAlign = TextAlign.start,
    String? unit,
  }) =>
      KayleeTextField(
        key: key,
        title: title,
        textInput: WithUnitInputField(
          textInputAction: textInputAction,
          focusNode: focusNode,
          nextFocusNode: nextFocusNode,
          controller: controller,
          error: error,
          hint: hint,
          textInputType: textInputType,
          textAlign: textAlign,
          unit: unit,
        ),
      );

  factory KayleeTextField.priceWithUnderline({
    String? title,
    dynamic price,
  }) =>
      KayleeTextField(
        title: title,
        textInput: PriceWithUnderLineBorderTextField(
          price: price,
        ),
      );

  factory KayleeTextField.search({
    String? hint,
    SearchInputFieldController? controller,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onDoneTyping,
    VoidCallback? onClear,
    EdgeInsets? inputPadding,
    double? height,
  }) =>
      KayleeTextField(
        textInput: TextFieldBorderWrapper(
          SearchInputField(
            hint: hint,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onDoneTyping: onDoneTyping,
            onClear: onClear,
            inputPadding: inputPadding,
          ),
          fieldHeight: height,
        ),
      );

  /// [fieldHeight] chiều cao của text field
  /// khi set [fieldHeight], để text field expand với chiều cao [fieldHeight], thì [expands] phải set = true
  factory KayleeTextField.normal(
          {Key? key,
          String? title,
          Widget? titleWidget,
          String? hint,
          double? fieldHeight,
          FocusNode? focusNode,
          FocusNode? nextFocusNode,
          TextEditingController? controller,
          TextInputAction textInputAction = TextInputAction.done,
          TextInputType? textInputType,
          String? error,
          EdgeInsets? contentPadding,
          bool expands = false,
          TextAlign textAlign = TextAlign.start,
          int? maxLength,
          ValueChanged<String>? onChanged}) =>
      KayleeTextField(
        key: key,
        title: title,
        titleWidget: titleWidget,
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
            maxLength: maxLength,
            onChanged: onChanged),
      );

  factory KayleeTextField.unitSelection({
    String? title,
    String? hint,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    String? error,
    ValueChanged<String>? onChange,
  }) =>
      KayleeTextField(
        title: title,
        textInput: UnitInputField(
          hint: hint,
          error: error,
          textInputAction: textInputAction,
          onChange: onChange,
          controller: controller,
        ),
      );

  factory KayleeTextField.multiLine({
    Key? key,
    String? title,
    String? hint,
    double fieldHeight = Dimens.px48,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    TextEditingController? controller,
    TextInputAction textInputAction = TextInputAction.done,
    String? error,
    EdgeInsets contentPadding =
        const EdgeInsets.symmetric(vertical: Dimens.px16),
    int? maxLength,
  }) =>
      KayleeTextField.normal(
        key: key,
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
        maxLength: maxLength,
      );

  factory KayleeTextField.selection(
          {String? title,
          String content = '',
          String? buttonText,
          String? error,
          VoidCallback? onPress}) =>
      KayleeTextField(
        title: title,
        textInput: SelectInputTextField(
          content: content,
          buttonText: buttonText,
          onPress: onPress,
          error: error,
        ),
      );

  factory KayleeTextField.staticPhone({
    Key? key,
    String? title,
    String? initText,
  }) =>
      KayleeTextField(
        key: key,
        title: title ?? StringsRes.soDienThoai,
        textInput: PhoneInputField(
          initText: initText,
          isStaticTField: true,
        ),
      );

  factory KayleeTextField.phoneInput(
          {Key? key,
          String? title,
          String? hint,
          FocusNode? focusNode,
          FocusNode? nextFocusNode,
          TextEditingController? controller,
          TextInputAction textInputAction = TextInputAction.done,
          String? error}) =>
      KayleeTextField(
        key: key,
        title: title ?? StringsRes.soDienThoai,
        textInput: PhoneInputField(
          hint: hint ?? StringsRes.phoneLimitHint,
          textInputAction: textInputAction,
          focusNode: focusNode,
          nextFocusNode: nextFocusNode,
          controller: controller,
          error: error,
        ),
      );

  factory KayleeTextField.staticWidget({String? title, String? initText}) =>
      KayleeTextField(
        title: title,
        textInput: NormalInputField(
          initText: initText,
          isStaticTField: true,
        ),
      );

  factory KayleeTextField.price(
          {String? title,
          String? hint,
          String? error,
          TextEditingController? controller,
          TextInputAction? textInputAction,
          FocusNode? focusNode,
          FocusNode? nextFocusNode}) =>
      KayleeTextField(
        title: title,
        textInput: PriceInputField(
          error: error,
          hint: hint,
          controller: controller,
          textInputAction: textInputAction,
          focusNode: focusNode,
          nextFocusNode: nextFocusNode,
        ),
      );

  factory KayleeTextField.staticPrice({String? title, dynamic initPrice}) =>
      KayleeTextField(
        title: title,
        textInput: PriceInputField(
          initText: CurrencyUtils.formatVNDWithCustomUnit(initPrice ?? 0),
          isStaticTField: true,
        ),
      );

  factory KayleeTextField.password({
    String? title,
    String? hint,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    String? error,
  }) =>
      KayleeTextField(
        title: title ?? StringsRes.matKhau,
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
        if ((title?.isNotEmpty ?? false) || titleWidget != null)
          Container(
            margin: const EdgeInsets.only(bottom: Dimens.px8),
            child: titleWidget ?? KayleeText.normal16W500(title!),
          ),
        if (textInput != null) textInput!,
      ],
    );
  }
}

class PriceInputField extends StatefulWidget {
  final String? hint;
  final String? error;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? initText;
  final bool isStaticTField;

  const PriceInputField(
      {Key? key,
      this.error,
      this.controller,
      this.hint,
      this.textInputAction,
      this.focusNode,
      this.nextFocusNode,
      this.initText,
      this.isStaticTField = false})
      : super(key: key);

  @override
  _PriceInputFieldState createState() => _PriceInputFieldState();
}

class _PriceInputFieldState extends BaseState<PriceInputField> {
  TextEditingController? tfController;

  @override
  void initState() {
    super.initState();
    _initDataIfStaticWidget();
  }

  @override
  void didUpdateWidget(PriceInputField oldWidget) {
    _updateDataIfStaticWidget();
    super.didUpdateWidget(oldWidget);
  }

  void _initDataIfStaticWidget() {
    _updateDataIfStaticWidget();
  }

  void _updateDataIfStaticWidget() {
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
    return ErrorText(
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
                focusNode: widget.focusNode,
                maxLines: 1,
                minLines: 1,
                controller:
                    widget.isStaticTField ? tfController : widget.controller,
                onSubmitted: (value) {
                  if (widget.textInputAction == TextInputAction.next) {
                    if (widget.textInputAction == TextInputAction.next) {
                      if (widget.nextFocusNode != null) {
                        widget.nextFocusNode!.requestFocus();
                      } else {
                        FocusScope.of(context).nextFocus();
                      }
                    }
                  }
                },
                enabled: !widget.isStaticTField,
                decoration: InputDecoration(
                    enabled: !widget.isStaticTField,
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
              child: KayleeText.normal16W400(StringsRes.vnd),
            )
          ],
        ),
      ),
      error: widget.error,
    );
  }
}

class SearchInputFieldController {
  _SearchInputFieldState? view;
  String? keyword;

  void clear() {
    view?.clear();
  }
}

class SearchInputField extends StatefulWidget {
  final String? hint;
  final SearchInputFieldController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onDoneTyping;
  final VoidCallback? onClear;
  final EdgeInsets? inputPadding;

  const SearchInputField({
    Key? key,
    this.hint,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onDoneTyping,
    this.onClear,
    this.inputPadding,
  }) : super(key: key);

  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends BaseState<SearchInputField> {
  final tfController = TextEditingController();
  bool closeIsShowed = false;
  final typingStreamController = StreamController<String>();

  @override
  void initState() {
    super.initState();
    widget.controller?.view = this;
    tfController.text = widget.controller?.keyword ?? '';
    closeIsShowed = widget.controller?.keyword?.isNotEmpty ?? false;
    typingStreamController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((keyword) {
      widget.onDoneTyping?.call(keyword);
    });
  }

  void clear() {
    if (closeIsShowed) {
      setState(() {
        tfController.clear();
        widget.controller?.keyword = tfController.text;
        closeIsShowed = !closeIsShowed;
      });
      widget.onClear?.call();
    }
  }

  @override
  void dispose() {
    tfController.dispose();
    typingStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.search,
      controller: tfController,
      textAlignVertical: TextAlignVertical.center,
      onChanged: (text) {
        widget.controller?.keyword = text;
        typingStreamController.add(text);
        widget.onChanged?.call(text);
        if (text.isNotEmpty && !closeIsShowed) {
          setState(() {
            closeIsShowed = !closeIsShowed;
          });
        } else if (text.isEmpty) {
          setState(() {
            closeIsShowed = !closeIsShowed;
          });
        }
      },
      decoration: InputDecoration(
          contentPadding: widget.inputPadding ??
              const EdgeInsets.only(
                  top: Dimens.px16, bottom: Dimens.px14, left: Dimens.px16),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: TextStyles.hint16W400,
          suffixIcon: GestureDetector(
            onTap: () {
              clear();
            },
            child: Icon(
              !closeIsShowed ? Icons.search : Icons.close,
              color: ColorsRes.hintText,
            ),
          )),
    );
  }
}

class WithUnitInputField extends StatefulWidget {
  final String? error;
  final String? hint;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final EdgeInsets contentPadding;
  final TextAlign textAlign;
  final String? unit;

  const WithUnitInputField({
    Key? key,
    this.hint,
    this.error,
    this.focusNode,
    this.controller,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.contentPadding = const EdgeInsets.only(bottom: Dimens.px4),
    this.textAlign = TextAlign.start,
    this.unit,
  }) : super(key: key);

  @override
  _WithUnitInputFieldState createState() => _WithUnitInputFieldState();
}

class _WithUnitInputFieldState extends BaseState<WithUnitInputField> {
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
    return ErrorText(
      child: TextFieldBorderWrapper(
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
                        if (widget.nextFocusNode != null) {
                          widget.nextFocusNode!.requestFocus();
                        } else {
                          FocusScope.of(context).nextFocus();
                        }
                      }
                    },
                    autofocus: false,
                    textAlign: widget.textAlign,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyles.normal16W400,
                    buildCounter: (context,
                            {required currentLength,
                            required isFocused,
                            required maxLength}) =>
                        null,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: widget.hint,
                      contentPadding: widget.contentPadding,
                      hintStyle: TextStyles.hint16W400,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: Dimens.px16),
                  margin: const EdgeInsets.symmetric(vertical: Dimens.px4),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: ColorsRes.textFieldBorder,
                              width: Dimens.px1))),
                  child: KayleeText.normal16W400(
                    widget.unit ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          isError: !widget.error.isNullOrEmpty),
      error: widget.error,
    );
  }
}

class NormalInputField extends StatefulWidget {
  final String? error;
  final String? hint;
  final String? initText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool isStaticTField;
  final double? fieldHeight;
  final EdgeInsets? contentPadding;
  final TextAlign textAlign;
  final bool expands;
  final int? maxLength;
  final Widget? suffixWidget;
  final BoxConstraints? suffixBoxConstraints;
  final ValueChanged<String>? onChanged;

  const NormalInputField({
    Key? key,
    this.hint,
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
    this.textAlign = TextAlign.start,
    this.expands = false,
    this.maxLength,
    this.suffixWidget,
    this.suffixBoxConstraints,
    this.onChanged,
  }) : super(key: key);

  @override
  _NormalInputFieldState createState() => _NormalInputFieldState();
}

class _NormalInputFieldState extends BaseState<NormalInputField> {
  bool showPass = false;
  TextEditingController? tfController;

  @override
  void initState() {
    super.initState();
    _initDataIfStaticWidget();
  }

  @override
  void didUpdateWidget(NormalInputField oldWidget) {
    _updateDataIfStaticWidget();
    super.didUpdateWidget(oldWidget);
  }

  void _initDataIfStaticWidget() {
    _updateDataIfStaticWidget();
  }

  void _updateDataIfStaticWidget() {
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
    return ErrorText(
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
                          widget.nextFocusNode?.requestFocus();
                        } else {
                          FocusScope.of(context).nextFocus();
                        }
                      }
                    },
                    onChanged: widget.onChanged,
                    autofocus: false,
                    obscureText: isPassTField ? !showPass : false,
                    textAlign: widget.textAlign,
                    textAlignVertical: TextAlignVertical.top,
                    expands: widget.expands,
                    maxLines: widget.expands ? null : 1,
                    minLines: widget.expands ? null : 1,
                    maxLength: widget.maxLength,
                    maxLengthEnforcement: widget.maxLength != null
                        ? MaxLengthEnforcement.enforced
                        : null,
                    style: TextStyles.normal16W400,
                    buildCounter: (context,
                            {required currentLength,
                            required isFocused,
                            required maxLength}) =>
                        null,
                    decoration: InputDecoration(
                        enabled: !widget.isStaticTField,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: widget.hint,
                        contentPadding: widget.contentPadding ??
                            const EdgeInsets.only(bottom: Dimens.px4),
                        hintStyle: TextStyles.hint16W400,
                        suffixIcon: widget.suffixWidget,
                        suffixIconConstraints: widget.suffixBoxConstraints ??
                            const BoxConstraints(minWidth: 0)),
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
                      IconAssets.icError,
                      width: Dimens.px16,
                      height: Dimens.px16,
                      package: anthPackage,
                    ),
                  )
              ],
            ),
          ),
          fieldHeight: widget.fieldHeight,
          bgColor: widget.isStaticTField ? Colors.transparent : null,
          isError: !widget.error.isNullOrEmpty),
      error: widget.error,
    );
  }
}

class PhoneInputField extends StatefulWidget {
  final String? initText;
  final String? hint;
  final String? error;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final bool isStaticTField;

  const PhoneInputField(
      {Key? key,
      this.error,
      this.focusNode,
      this.controller,
      this.nextFocusNode,
      this.textInputAction = TextInputAction.done,
      this.isStaticTField = false,
      this.initText,
      this.hint})
      : super(key: key);

  @override
  _PhoneInputFieldState createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  TextEditingController? tfController;

  @override
  void initState() {
    super.initState();
    _initDataIfStaticWidget();
  }

  @override
  void didUpdateWidget(PhoneInputField oldWidget) {
    _updateDataIfStaticWidget();
    super.didUpdateWidget(oldWidget);
  }

  void _initDataIfStaticWidget() {
    _updateDataIfStaticWidget();
  }

  void _updateDataIfStaticWidget() {
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
    return ErrorText(
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
                enabled: !widget.isStaticTField,
                textInputAction: widget.textInputAction,
                onSubmitted: (_) {
                  if (widget.textInputAction == TextInputAction.next) {
                    if (widget.nextFocusNode.isNotNull) {
                      widget.nextFocusNode?.requestFocus();
                    } else {
                      FocusScope.of(context).nextFocus();
                    }
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
  final String? error;
  final TextEditingController? websiteTfController;
  final TextEditingController? domainTfController;
  final FocusNode? websiteFocus;
  final FocusNode? domainFocus;
  final TextInputAction? textInputAction;

  const WebsiteInputField(
      {Key? key,
      this.error,
      this.websiteFocus,
      this.domainFocus,
      this.websiteTfController,
      this.domainTfController,
      this.textInputAction})
      : super(key: key);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorText(
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
                    hintText: StringsRes.websiteHint,
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
                    hintText: StringsRes.domainHint,
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
        isError: !widget.error.isNullOrEmpty,
      ),
      error: widget.error,
    );
  }
}

class SelectInputTextField extends StatefulWidget {
  final String? error;
  final String content;
  final String? buttonText;
  final VoidCallback? onPress;

  const SelectInputTextField(
      {Key? key, this.error, this.content = '', this.onPress, this.buttonText})
      : super(key: key);

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
    return ErrorText(
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
              widget.content,
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
  final String? hint;
  final String? error;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;

  const UnitInputField(
      {Key? key,
      this.hint,
      this.error,
      this.textInputAction,
      this.onChange,
      this.controller})
      : super(key: key);

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
    return ErrorText(
      child: TextFieldBorderWrapper(Row(
        children: [
          Expanded(
            flex: (2510 / 343).round(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: TextField(
                controller: widget.controller,
                style: TextStyles.normal16W400,
                keyboardType: TextInputType.number,
                textInputAction: widget.textInputAction,
                onChanged: widget.onChange,
                onSubmitted: (value) {
                  if (widget.textInputAction == TextInputAction.next) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[1-9]$|^[1-9][0-9]$|^(100)$'))
                ],
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
                    IconAssets.icDown,
                    package: anthPackage,
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

class PriceWithUnderLineBorderTextField extends StatefulWidget {
  final dynamic price;

  const PriceWithUnderLineBorderTextField({Key? key, this.price})
      : super(key: key);

  @override
  _PriceWithUnderLineBorderTextFieldState createState() =>
      _PriceWithUnderLineBorderTextFieldState();
}

class _PriceWithUnderLineBorderTextFieldState
    extends BaseState<PriceWithUnderLineBorderTextField> {
  final _tfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tfController.text = CurrencyUtils.formatVNDWithCustomUnit(widget.price);
  }

  @override
  void didUpdateWidget(PriceWithUnderLineBorderTextField oldWidget) {
    _tfController.text = CurrencyUtils.formatVNDWithCustomUnit(widget.price);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _tfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.px48,
      child: TextField(
        enabled: false,
        controller: _tfController,
        style: TextStyles.normal16W400,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
            disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              width: Dimens.px1,
              color: ColorsRes.hintText,
            )),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: Dimens.px8),
              child: KayleeText.hint16W400(
                StringsRes.vnd,
                textAlign: TextAlign.center,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(),
            enabled: false),
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  final String? error;
  final Widget? child;

  const ErrorText({Key? key, this.child, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (child != null) child!,
        if (error != null && error!.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: Dimens.px4),
            alignment: Alignment.centerRight,
            child: KayleeText.error12W400(
              error!,
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
  final bool isError;
  final Color? bgColor;
  final double? fieldHeight;
  final bool focused;

  const TextFieldBorderWrapper(this.child,
      {Key? key,
      this.isError = false,
      this.bgColor,
      this.fieldHeight,
      this.focused = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fieldHeight ?? Dimens.px48,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(Dimens.px5),
        border: Border.all(
            width: isError ? Dimens.px2 : Dimens.px1,
            color: isError ? ColorsRes.errorBorder : ColorsRes.textFieldBorder),
        boxShadow: [
          if (focused)
            const BoxShadow(
                color: Color(0x4c000000),
                offset: Offset(0, 1),
                blurRadius: 5,
                spreadRadius: 0)
        ],
      ),
      child: child,
    );
  }
}
