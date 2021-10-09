import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class CommOrderItem extends StatelessWidget {
  final DateTime? date;
  final String? code;
  final String? name;
  final dynamic commissionAmount;

  const CommOrderItem({
    Key? key,
    this.date,
    this.code,
    this.name,
    this.commissionAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: ColorsRes.textFieldBorder,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.px5),
        side: const BorderSide(
          color: ColorsRes.textFieldBorder,
          width: Dimens.px1,
        ),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: Dimens.px96,
            child: KayleeText.normal18W700(
              date?.toFormatString(pattern: 'dd/MM') ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(Dimens.px16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KayleeText.normal16W500(
                    '#$code',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.px8),
                    child: KayleeText.hint16W400(
                      name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  KayleeText.hyper16W400(
                    '${Strings.hoaHong}: ${CurrencyUtils.formatVNDWithCustomUnit(commissionAmount)} ',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
