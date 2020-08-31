import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryItem extends StatelessWidget {
  final Order order;

  HistoryItem({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px117,
      child: KayleeInkwell(
        borderRadius: BorderRadius.circular(Dimens.px5),
        onTap: () {
          context.push(PageIntent(screen: HistoryDetailScreen));
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
                        '#0001546',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: KayleeText.normal16W400(
                        orderStatus2Title(status: OrderStatus.cancel),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimens.px16).copyWith(bottom: 7),
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeText.normal16W500(
                        order?.name ?? 'asdfsadf',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: KayleePriceText.normal(
                        order?.amount ?? 1000000,
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
                  'T2, 16/06/2020',
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
