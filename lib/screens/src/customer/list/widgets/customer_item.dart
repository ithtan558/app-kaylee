import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class CustomerItem extends StatelessWidget {
  final Function() onTap;
  final Customer customer;

  CustomerItem({this.onTap, this.customer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        KayleeInkwell(
          child: KayleeCartView(
              itemHeight: double.infinity,
              child: KayleeImageInfoLayout(
                imageView: Image.network(
                  customer?.image ?? '',
                  fit: BoxFit.cover,
                ),
                infoView: Padding(
                  padding: const EdgeInsets.only(top: Dimens.px16),
                  child: KayleeText.hyper16W500(
                    customer?.name ?? '',
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
                  onTap: () {
                    makeCall(customer.phone);
                  },
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
