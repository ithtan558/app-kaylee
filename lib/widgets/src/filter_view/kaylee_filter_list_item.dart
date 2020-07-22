import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeFilterListItem extends StatefulWidget {
  final String title;
  final void Function(bool isSelected) onTap;
  final bool disable;

  KayleeFilterListItem({this.title, this.onTap, this.disable = false});

  @override
  _KayleeFilterListItemState createState() => new _KayleeFilterListItemState();
}

class _KayleeFilterListItemState extends BaseState<KayleeFilterListItem> {
  bool isSelected = false;

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
    return KayleeRoundBorder(
      borderRadius: BorderRadius.circular(Dimens.px5),
      borderWidth: isSelected ? Dimens.px2 : Dimens.px1,
      borderColor: isSelected ? ColorsRes.hyper : ColorsRes.textFieldBorder,
      onTap: widget.disable
          ? null
          : () {
              setState(() {
                isSelected = !isSelected;
              });
              if (widget.onTap != null) {
                widget.onTap(isSelected);
              }
            },
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.px8, vertical: Dimens.px9),
      child: KayleeText.normal12W400(
        widget.title,
        overflow: TextOverflow.visible,
      ),
    );
  }
}

class WrapperFilter extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final bool isAll;

  WrapperFilter({this.children, this.title, this.isAll = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!title.isNullOrEmpty)
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text(title,
                style:
                    isAll ? TextStyles.normal16W500 : TextStyles.normal12W400),
          ),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: Dimens.px16,
          spacing: Dimens.px16,
          children: <Widget>[if (children.isNotNullAndEmpty) ...children],
        ),
      ],
    );
  }
}
