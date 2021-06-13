import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_customer/select_customer_dialog.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectCustomerField extends StatefulWidget {
  final ValueChanged<Customer> onSelect;
  final SelectCustomerController controller;

  SelectCustomerField({required this.onSelect, required this.controller});

  @override
  _SelectCustomerFieldState createState() => _SelectCustomerFieldState();
}

class _SelectCustomerFieldState extends KayleeState<SelectCustomerField> {
  @override
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == SelectCustomerField && bundle?.args is Customer) {
      this.widget.controller.customer = bundle!.args;
      this.widget.onSelect.call(this.widget.controller.customer!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return KayleeTextField.selection(
      title: Strings.thongTinKh,
      content: widget.controller.customer?.name ?? '',
      buttonText: Strings.chinhSua,
      onPress: () {
        showKayleeDialog(
          context: context,
          borderRadius: BorderRadius.circular(Dimens.px5),
          margin: const EdgeInsets.all(Dimens.px8),
          showFullScreen: true,
          showShadow: true,
          child: SelectCustomerDialog.newInstance(
            onSelect: (value) {
              widget.controller.customer = value;
              widget.onSelect.call(widget.controller.customer!);
              setState(() {});
            },
          ),
        );
      },
    );
  }
}

class SelectCustomerController {
  Customer? customer;

  SelectCustomerController({this.customer});
}
