import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CustomerItem extends StatelessWidget {
  final Function() onTap;

  CustomerItem({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        KayleeInkwell(
          child: KayleeCartView(
              child: KayleeImageInfoLayout(
            imageView: Image.network(
              'https://s3.amazonaws.com/tinycards/image/c5b605125dd3a4685555bf56c37555ed',
              fit: BoxFit.cover,
            ),
            infoView: Padding(
              padding: const EdgeInsets.only(top: Dimens.px16),
              child: KayleeText.hyper16W500(
                'Willard Chavez',
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          )),
          onTap: onTap,
        ),
        Positioned(
          left: 0,
          right: 0,
          child: FractionallySizedBox(
            widthFactor: 40 / 103,
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1,
              child: Material(
                clipBehavior: Clip.antiAlias,
                type: MaterialType.circle,
                color: ColorsRes.button,
                child: InkWell(
                  onTap: () {},
                  child: const Icon(
                    CupertinoIcons.phone,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          bottom: Dimens.px16,
        )
      ],
    );
  }
}
