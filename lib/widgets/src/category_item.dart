import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';

class CategoryItem extends StatelessWidget {
  final int? index;
  final String? name;
  final VoidCallback? onTap;

  const CategoryItem({Key? key, this.index, this.name, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.px48,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimens.px5),
                border: const Border.fromBorderSide(BorderSide(
                    width: 1,
                    color: Color(0xff979797),
                    style: BorderStyle.solid))),
            width: Dimens.px48,
            height: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(Dimens.px8),
            child: KayleeText.normal16W500(
              index?.toString() ?? '',
              maxLines: 1,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: Dimens.px16),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.px5),
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xff979797),
                    )),
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    onTap?.call();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    padding: const EdgeInsets.only(
                        left: Dimens.px26, right: Dimens.px28),
                    child: KayleeText.normal16W500(
                      name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
