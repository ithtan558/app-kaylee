import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class SupplierInfoSwitchBar extends StatefulWidget {
  final ValueChanged<int> onTabChanged;

  const SupplierInfoSwitchBar({Key? key, required this.onTabChanged})
      : super(key: key);

  @override
  State<SupplierInfoSwitchBar> createState() => _SupplierInfoSwitchBarState();
}

class _SupplierInfoSwitchBarState extends State<SupplierInfoSwitchBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: Row(
        children: [
          Expanded(
            child: _buildButton(
              title: Strings.sanPham,
              selected: _index == 0,
              onTap: () {
                setState(() {
                  _index = 0;
                });
                widget.onTabChanged(_index);
              },
            ),
          ),
          const SizedBox(width: Dimens.px16),
          Expanded(
            child: _buildButton(
              title: Strings.thongTinShop,
              selected: _index == 1,
              onTap: () {
                setState(() {
                  _index = 1;
                });
                widget.onTabChanged(_index);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required VoidCallback onTap,
    bool selected = false,
  }) {
    return KayleeFlatButton(
      title: title,
      height: Dimens.px48,
      background: selected ? ColorsRes.hyper : ColorsRes.textFieldBorder,
      style: selected ? TextStyles.normalWhite16W500 : TextStyles.hint16W500,
      onPress: onTap,
    );
  }
}
