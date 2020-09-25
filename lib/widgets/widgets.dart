library widgets;

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/src/hyper_link_text.dart';

export 'src/brand_select_textfield/brand_select_textfield.dart';
export 'src/category_item.dart';
export 'src/filter_button/filter_button.dart';
export 'src/filter_view/kaylee_filter_list_item.dart';
export 'src/filter_view/kaylee_filter_view.dart';
export 'src/hyper_link_text.dart';
export 'src/kaylee_appbar.dart';
export 'src/kaylee_bottom_bar.dart';
export 'src/kaylee_cart_prod_item/kaylee_cart_prod_item.dart';
export 'src/kaylee_cart_view.dart';
export 'src/kaylee_date_filter.dart';
export 'src/kaylee_date_picker.dart';
export 'src/kaylee_dialog.dart';
export 'src/kaylee_dismissible.dart';
export 'src/kaylee_flat_button.dart';
export 'src/kaylee_float_button.dart';
export 'src/kaylee_full_address_input.dart';
export 'src/kaylee_grid_view.dart';
export 'src/kaylee_header_card.dart';
export 'src/kaylee_image_info_layout.dart';
export 'src/kaylee_image_picker.dart';
export 'src/kaylee_incr_decr_buttons.dart';
export 'src/kaylee_inkwell.dart';
export 'src/kaylee_list_view.dart';
export 'src/kaylee_loading_indicator.dart';
export 'src/kaylee_loadmore_handler.dart';
export 'src/kaylee_picker_textfield.dart';
export 'src/kaylee_price_range.dart';
export 'src/kaylee_prod_item.dart';
export 'src/kaylee_refresh_indicator.dart';
export 'src/kaylee_round_border.dart';
export 'src/kaylee_rounded_button.dart';
export 'src/kaylee_scrollview.dart';
export 'src/kaylee_tab_view/kaylee_tab_view.dart';
export 'src/kaylee_text.dart';
export 'src/kaylee_text_field.dart';
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
              context.push(PageIntent(screen: RegisterScreen));
            },
          ),
        ),
      ],
    );
  }
}
