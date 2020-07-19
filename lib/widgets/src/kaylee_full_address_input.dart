import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeFullAddressInput extends StatefulWidget {
  final String title;
  final EdgeInsets padding;
  final KayleeFullAddressController controller;

  KayleeFullAddressInput({this.title, this.padding, this.controller});

  @override
  _KayleeFullAddressInputState createState() =>
      new _KayleeFullAddressInputState();
}

class _KayleeFullAddressInputState extends BaseState<KayleeFullAddressInput> {
  final tfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller?._view = this;
  }

  @override
  void dispose() {
    tfController.dispose();
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
            controller: tfController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.px8),
            child: Row(
              children: [
                Expanded(
                  child: KayleePickerTextField(
                    hint: Strings.phuong,
                  ),
                ),
                SizedBox(width: Dimens.px8),
                Expanded(
                  child: KayleePickerTextField(
                    hint: Strings.quan,
                  ),
                ),
              ],
            ),
          ),
          KayleePickerTextField<City>(
            hint: Strings.tinhTpHint,
          ),
        ],
      ),
    );
  }
}

class KayleeFullAddressController {
  _KayleeFullAddressInputState _view;

  String get address => _view?.tfController?.text ?? '';

//  City get city => _view.city;
//
//  District get district => _view.district;
//
//  Ward get ward => _view.ward;
}
