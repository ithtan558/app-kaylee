import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class CommOrderItem extends StatelessWidget {
  final DateTime date;
  final String code;
  final String name;
  final dynamic commissionAmount;

  CommOrderItem({
    this.date,
    this.code,
    this.name,
    this.commissionAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px103,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.fromBorderSide(BorderSide(
          color: ColorsRes.textFieldBorder,
          width: Dimens.px1,
        )),
        borderRadius: BorderRadius.circular(Dimens.px5),
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: ColorsRes.textFieldBorder,
              alignment: Alignment.center,
              child: KayleeText.normal18W700(
                date?.toFormatString(pattern: 'dd/MM') ?? '',
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
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
                  KayleeText.hint16W400(
                    name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  KayleeText.hyper16W400(
                    '${Strings.hoaHong}: ${CurrencyUtils.formatVNDWithCustomUnit(commissionAmount, unit: Strings.vnd)} ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
