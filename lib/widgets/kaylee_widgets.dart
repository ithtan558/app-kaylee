library kayle_widgets;

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/signup/signup_screen.dart';
import 'package:kaylee/widgets/src/hyper_link_text.dart';

export 'src/filter_popup_view/kaylee_filter_popup_view.dart';
export 'src/filter_view/kaylee_filter_list_item.dart';
export 'src/filter_view/kaylee_filter_view.dart';
export 'src/hyper_link_text.dart';
export 'src/kaylee_appbar.dart';
export 'src/kaylee_bottom_bar.dart';
export 'src/kaylee_cart_view.dart';
export 'src/kaylee_dismissible.dart';
export 'src/kaylee_flat_button.dart';
export 'src/kaylee_float_button.dart';
export 'src/kaylee_grid_view.dart';
export 'src/kaylee_image_info_layout.dart';
export 'src/kaylee_image_picker.dart';
export 'src/kaylee_incr_decr_buttons.dart';
export 'src/kaylee_inkwell.dart';
export 'src/kaylee_prod_item.dart';
export 'src/kaylee_rounded_button.dart';
export 'src/kaylee_text.dart';
export 'src/kaylee_text_field.dart';
export 'src/kaylle_full_address_input.dart';
export 'src/label_divider_view.dart';
export 'src/policy_checkbox.dart';

class Go2RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.chuaCoTK),
        Container(
          margin: EdgeInsets.only(left: Dimens.px8),
          child: HyperLinkText(
            text: Strings.dangKy,
            onTap: () {
              push(PageIntent(context, SignUpScreen));
            },
          ),
        ),
      ],
    );
  }
}
