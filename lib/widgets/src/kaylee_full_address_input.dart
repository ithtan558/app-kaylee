import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeFullAddressInput extends StatefulWidget {
  final String title;
  final EdgeInsets padding;
  final KayleeFullAddressController controller;

  KayleeFullAddressInput({Key key, this.title, this.padding, this.controller})
      : super(key: key);

  @override
  _KayleeFullAddressInputState createState() =>
      new _KayleeFullAddressInputState();
}

class _KayleeFullAddressInputState extends BaseState<KayleeFullAddressInput> {
  final addressTFController = TextEditingController();
  final cityController = PickInputController<City>();
  final districtController = PickInputController<District>();
  final wardController = PickInputController<Ward>();
  final addressFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller?._view = this;
    addressTFController.text = widget.controller?.initAddress ?? '';
    cityController.value = widget.controller?.initCity;
    districtController.value = widget.controller?.initDistrict;
    wardController.value = widget.controller?.initWard;
  }

  @override
  void didUpdateWidget(KayleeFullAddressInput oldWidget) {
    if (addressTFController.text != oldWidget.controller?.initAddress) {
      addressTFController.text = widget.controller?.initAddress ?? '';
    }
    if (cityController.value?.id != oldWidget.controller?.initCity?.id) {
      cityController.value = widget.controller?.initCity;
    }
    if (districtController.value?.id !=
        oldWidget.controller?.initDistrict?.id) {
      districtController.value = widget.controller?.initDistrict;
    }
    if (wardController.value?.id != oldWidget.controller?.initWard?.id) {
      wardController.value = widget.controller?.initWard;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    addressTFController.dispose();
    addressFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: RepositoryProvider<KayleePickerTextFieldModel>(
        create: (context) => KayleePickerTextFieldModel(),
        child: Column(
          children: [
            KayleePickerTextField<City>(
              title: widget.title,
              hint: Strings.tinhTpHint,
              controller: cityController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.px8),
              child: Row(
                children: [
                  Expanded(
                    child: KayleePickerTextField<District>(
                      hint: Strings.quan,
                      controller: districtController,
                    ),
                  ),
                  SizedBox(width: Dimens.px8),
                  Expanded(
                    child: KayleePickerTextField<Ward>(
                      hint: Strings.phuong,
                      controller: wardController,
                    ),
                  ),
                ],
              ),
            ),
            KayleeTextField.normal(
              hint: Strings.diaChiHienTaiHint,
              textInputAction: TextInputAction.done,
              controller: addressTFController,
              focusNode: addressFocus,
            ),
          ],
        ),
      ),
    );
  }
}

class KayleeFullAddressController {
  _KayleeFullAddressInputState _view;

  KayleeFullAddressController(
      {this.initAddress, this.initCity, this.initDistrict, this.initWard});

  String initAddress;
  City initCity;
  District initDistrict;
  Ward initWard;

  String get address => _view?.addressTFController?.text ?? '';

  void focusAddress() => _view?.addressFocus?.requestFocus();

  City get city => _view?.cityController?.value;

  District get district => _view?.districtController?.value;

  Ward get ward => _view?.wardController?.value;
}
