import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class OtpInputField extends StatefulWidget {
  final ValueSetter<String> onComplete;
  final String? error;

  const OtpInputField({Key? key, required this.onComplete, this.error})
      : super(key: key);

  @override
  _OtpInputFieldState createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends BaseState<OtpInputField> {
  final pinFocus1 = FocusNode();
  final pinFocus2 = FocusNode();
  final pinFocus3 = FocusNode();
  final pinFocus4 = FocusNode();
  final tfController1 = TextEditingController();
  final tfController2 = TextEditingController();
  final tfController3 = TextEditingController();
  final tfController4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    pinFocus1.addListener(() {
      validateTField(tfController1, pinFocus2,
          previousTfController: null, nextTfController: tfController2);
    });
    pinFocus2.addListener(() {
      validateTField(tfController2, pinFocus3,
          previousTfController: tfController2, nextTfController: tfController3);
    });
    pinFocus3.addListener(() {
      validateTField(tfController3, pinFocus4,
          previousTfController: tfController3, nextTfController: null);
    });
  }

  void validateTField(
      TextEditingController currentTfController, FocusNode nextFocus,
      {TextEditingController? previousTfController,
      TextEditingController? nextTfController}) {
    if (tfController1.text.isNotEmpty &&
        tfController2.text.isNotEmpty &&
        tfController3.text.isNotEmpty &&
        tfController4.text.isNotEmpty) {
      nextFocus.requestFocus();
    }
  }

  @override
  void dispose() {
    pinFocus1.dispose();
    pinFocus2.dispose();
    pinFocus3.dispose();
    pinFocus4.dispose();

    tfController1.dispose();
    tfController2.dispose();
    tfController3.dispose();
    tfController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PinTextField(
                currentFocus: pinFocus1,
                nextFocus: pinFocus2,
                tfController: tfController1,
                autoFocus: true,
              ),
              _PinTextField(
                currentFocus: pinFocus2,
                nextFocus: pinFocus3,
                tfController: tfController2,
              ),
              _PinTextField(
                currentFocus: pinFocus3,
                nextFocus: pinFocus4,
                tfController: tfController3,
              ),
              _PinTextField(
                currentFocus: pinFocus4,
                textInputAction: TextInputAction.done,
                tfController: tfController4,
                onComplete: () {
                  final code =
                      '${tfController1.text}${tfController2.text}${tfController3.text}${tfController4.text}';
                  widget.onComplete(code);
                },
              ),
            ],
          ),
        ),
        if (widget.error?.isNotEmpty ?? false)
          KayleeText.error12W400(widget.error!),
      ],
    );
  }
}

class _PinTextField extends StatefulWidget {
  final FocusNode? nextFocus;
  final FocusNode? currentFocus;
  final TextInputAction? textInputAction;
  final TextEditingController? tfController;
  final VoidCallback? onComplete;
  final bool autoFocus;

  const _PinTextField(
      {this.nextFocus,
      this.currentFocus,
      this.textInputAction = TextInputAction.next,
      this.tfController,
      this.onComplete,
      this.autoFocus = false});

  @override
  _PinTextFieldState createState() => _PinTextFieldState();
}

class _PinTextFieldState extends BaseState<_PinTextField> {
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
    return Container(
      width: Dimens.px16,
//      color: Colors.blue,
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px12),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if ((widget.tfController?.text)?.isEmpty ?? true)
            Container(
                width: Dimens.px16,
                height: Dimens.px16,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    color: ColorsRes.hintText, shape: BoxShape.circle)),
          TextField(
            controller: widget.tfController,
            focusNode: widget.currentFocus,
            textInputAction: widget.textInputAction,
            keyboardType: TextInputType.number,
            style: TextStyles.normal26W700,
            autofocus: widget.autoFocus,
            onChanged: (pin) {
              setState(() {});
              if (pin.isEmpty) {
                widget.currentFocus?.previousFocus();
              } else if (pin.isNotEmpty) {
                widget.onComplete?.call();
                widget.currentFocus?.nextFocus();
              }
            },
            maxLength: 1,
            maxLines: 1,
            minLines: 1,
//            showCursor: false,
            enableInteractiveSelection: false,
            buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    required maxLength}) =>
                Container(),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: -8),
            ),
          ),
        ],
      ),
    );
  }
}
