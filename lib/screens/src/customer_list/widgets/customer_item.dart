import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CustomerItem extends StatelessWidget {
  final Function() onTap;

  CustomerItem({this.onTap});

  @override
  Widget build(BuildContext context) {
    return KayleeInkwell(
      child: KayleeCartView(
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
              padding: const EdgeInsets.only(top: Dimens.px16),
              child: FractionallySizedBox(
                widthFactor: 40 / 103,
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      print('[TUNG] ===> FlatButton');
                    },
                    color: ColorsRes.button,
                    shape: CircleBorder(),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
      onTap: onTap,
    );
  }
}
