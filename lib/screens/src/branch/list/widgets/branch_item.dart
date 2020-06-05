import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class BranchItem extends StatelessWidget {
  final void Function() onTap;

  BranchItem({this.onTap});

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
                    'https://4.bp.blogspot.com/-Ol8xX1AEVwA/V8Z4x_ILPAI/AAAAAAAAH0s/gn3uRTi6ZdYOAuQ-otFBKM3_guiu92lngCLcB/s1600/annam%25281%2529.jpg',
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
                        KayleeText.normalWhite16W500('Annam Spa & Fitness'),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: Dimens.px4),
                          child: KayleeText.textFieldBorder12W400(
                            '35/6A Nguyễn Đình Chiểu, P6, Q3, Tp.HCM',
                            maxLines: 1,
                          ),
                        ),
                        KayleeText.textFieldBorder12W400(
                          'Giờ mở cửa: 10:00 AM - 11:00 PM',
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
                onTap: onTap,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
