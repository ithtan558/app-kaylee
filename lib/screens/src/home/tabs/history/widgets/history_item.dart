import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryItem extends StatelessWidget {
  final Order order;

  HistoryItem({this.order});

  @override
  Widget build(BuildContext context) {
    final date = (order?.createdAtInDateTime?.weekday ?? -1);
    return Container(
      height: Dimens.px118,
      child: KayleeInkwell(
        borderRadius: BorderRadius.circular(Dimens.px5),
        onTap: () {
          context.push(PageIntent(
              screen: HistoryOrderDetailScreen, bundle: Bundle(order)));
        },
        child: KayleeCartView(
          borderRadius: BorderRadius.circular(Dimens.px5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: Dimens.px40,
                width: double.infinity,
                color: ColorsRes.textFieldBorder,
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeText.normal16W500(
                        '#${order.code ?? ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: KayleeText.normal16W400(
                        orderStatus2Title(status: order.status),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(Dimens.px16).copyWith(bottom: Dimens.px8),
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeText.normal16W500(
                        order?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: KayleePriceText.normal(
                        order?.amount ?? 0,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                    .copyWith(bottom: Dimens.px16),
                child: KayleeText.hint16W400(
                  '${date == DateTime.sunday ? 'CN' : 'T${date + 1}'} ${order
                      ?.createdAtInDateTime?.toFormatString(
                      pattern: dateFormat2)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
