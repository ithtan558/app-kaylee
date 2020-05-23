import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ServiceItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.px23),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: KayleeText(
                "x1 Cắt tóc",
                style: TextStyles.normal16W400,
                maxLines: 1,
              )),
              KayleePriceUnitText(90000)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
            child: KayleeTextField.staticWidget(
              title: 'Nhân viên thực hiện',
              initText: 'Maria',
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            decoration: new BoxDecoration(color: ColorsRes.textFieldBorder),
          )
        ],
      ),
    );
  }
}
