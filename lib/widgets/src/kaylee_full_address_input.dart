import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeFullAddressInput extends StatefulWidget {
  final String title;
  final EdgeInsets padding;

  KayleeFullAddressInput({this.title, this.padding});

  @override
  _KayleeFullAddressInputState createState() =>
      new _KayleeFullAddressInputState();
}

class _KayleeFullAddressInputState extends BaseState<KayleeFullAddressInput> {
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
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          KayleeTextField.normal(
            title: widget.title,
            hint: Strings.diaChiHienTaiHint,
            textInputAction: TextInputAction.done,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.px8),
            child: Row(
              children: [
                Expanded(
                    child: KayleeTextField(
                  textInput: PickerInputField(
                    hint: Strings.phuong,
                  ),
                )),
                SizedBox(width: Dimens.px8),
                Expanded(
                    child: KayleeTextField(
                      textInput: PickerInputField(
                    hint: Strings.quan,
                  ),
                )),
              ],
            ),
          ),
          KayleeTextField(
            textInput: PickerInputField(
              hint: Strings.tinhTpHint,
            ),
          ),
        ],
      ),
    );
  }
}
