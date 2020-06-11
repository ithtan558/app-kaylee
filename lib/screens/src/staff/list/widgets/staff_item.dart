import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class StaffItem extends StatelessWidget {
  final void Function() onTap;

  StaffItem({this.onTap});

  @override
  Widget build(BuildContext context) {
    return KayleeInkwell(
      child: KayleeCartView(
          itemHeight: double.infinity,
          child: KayleeImageInfoLayout(
            imageView: Image.network(
              'https://s3.amazonaws.com/tinycards/image/c5b605125dd3a4685555bf56c37555ed',
              fit: BoxFit.cover,
            ),
            infoView: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KayleeText.hyper16W500(
                  'Willard Chavez',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.px4),
                  child: KayleeText.hint16W400(
                    'Kế toán',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )),
      onTap: onTap,
    );
  }
}
