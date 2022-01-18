import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeFilterListItem extends StatefulWidget {
  final String title;
  final void Function(bool isSelected)? onTap;
  final bool disable;

  const KayleeFilterListItem({Key? key, required this.title, this.onTap, this.disable = false})
      : super(key: key);

  @override
  _KayleeFilterListItemState createState() => _KayleeFilterListItemState();
}

class _KayleeFilterListItemState extends BaseState<KayleeFilterListItem> {
  bool isSelected = false;

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
        widget.onTap?.call(isSelected);
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
  final List<Widget>? children;
  final String? title;
  final bool isAll;

  const WrapperFilter({Key? key, this.children, this.title, this.isAll = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title?.isNotEmpty ?? false)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Text(title!,
                style:
                isAll ? TextStyles.normal16W500 : TextStyles.normal12W400),
          ),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: Dimens.px16,
          spacing: Dimens.px16,
          children: [
            if (children?.isNotEmpty ?? false) ...children!.sublist(0, 1)
          ],
        ),
      ],
    );
  }
}
