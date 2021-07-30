import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class HomeMenuItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;

  const HomeMenuItem(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemWidth = (context.screenSize.width - Dimens.px16 * 2) / 4;
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(Dimens.px8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: itemWidth,
          height: itemWidth,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  icon,
                  width: context.scaleWidth(Dimens.px24),
                  height: context.scaleWidth(Dimens.px24),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    textScaleFactor: context.screenWidthRatio,
                    style: TextStyles.normalWhite12W400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
