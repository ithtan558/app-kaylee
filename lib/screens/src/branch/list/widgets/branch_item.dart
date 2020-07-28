import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/widgets.dart';

class BranchItem extends StatelessWidget {
  final Brand brand;

  BranchItem({this.brand});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(Dimens.px10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: Dimens.px52),
                child: AspectRatio(
                  aspectRatio: 343 / 188,
                  child: Image.network(
                    brand.image ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: Dimens.px8,
                      bottom: Dimens.px16,
                      left: Dimens.px16,
                      right: Dimens.px16,
                    ),
                    color: ColorsRes.text,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KayleeText.normalWhite16W500(brand.name ?? ''),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: Dimens.px4),
                          child: KayleeText.textFieldBorder12W400(
                            brand.location ?? '',
                            maxLines: 1,
                          ),
                        ),
                        KayleeText.textFieldBorder12W400(
                          'Giờ mở cửa: ${brand.start.formattedTime} - ${brand.end.formattedTime}',
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.push(PageIntent(
                      screen: CreateNewBranchScreen,
                      bundle: Bundle(NewBranchScreenData(
                          openFrom: BranchScreenOpenFrom.branchItem,
                          branch: brand))));
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
