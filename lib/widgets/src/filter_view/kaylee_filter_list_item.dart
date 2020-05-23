import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeFilterListItem extends StatefulWidget {
  final String title;
  final void Function(bool isSelected) onTap;

  KayleeFilterListItem({this.title, this.onTap});

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
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.px5),
        side: BorderSide(
          width: isSelected ? Dimens.px2 : Dimens.px1,
          color: isSelected ? ColorsRes.hyper : ColorsRes.textFieldBorder,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          if (widget.onTap != null) {
            widget.onTap(isSelected);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.px8, vertical: Dimens.px9),
          child: Text(widget.title,
              style: theme.textTheme.bodyText2.copyWith(
                fontSize: Dimens.px12,
              )),
        ),
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
                style: ScreenUtils.textTheme(context).bodyText2.copyWith(
                      fontSize: isAll ? Dimens.px16 : Dimens.px12,
                      fontWeight: isAll ? FontWeight.w500 : FontWeight.w400,
                    )),
          ),
        Wrap(
          direction: Axis.horizontal,
          runSpacing: Dimens.px16,
          spacing: Dimens.px16,
          children: <Widget>[if (!children.isNullOrEmpty) ...children],
        ),
      ],
    );
  }
}
