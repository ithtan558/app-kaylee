library widgets;

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/screens.dart';

export 'src/brand_select_textfield/brand_select_textfield.dart';
export 'src/filter_button/filter_button.dart';
export 'src/filter_view/kaylee_filter_list_item.dart';
export 'src/kaylee_full_address_input.dart';
export 'src/kaylee_grid_view.dart';
export 'src/kaylee_html_widget.dart';
export 'src/kaylee_image_picker.dart';
export 'src/kaylee_list_view.dart';
export 'src/kaylee_loadmore_handler.dart';
export 'src/kaylee_picker_textfield.dart';
export 'src/kaylee_refresh_indicator.dart';
export 'src/policy_checkbox.dart';
export 'src/print_bill_dialog/print_bill_dialog.dart';

class Go2RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(Strings.chuaCoTK),
        Container(
          margin: const EdgeInsets.only(left: Dimens.px8),
          child: HyperLinkText(
            text: Strings.dangKy,
            onTap: () {
              context.push(PageIntent(screen: RegisterScreen));
            },
          ),
        ),
      ],
    );
  }

  const Go2RegisterText({Key? key}) : super(key: key);
}
