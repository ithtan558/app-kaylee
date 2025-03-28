import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/screens.dart';

class CustomerItem extends StatelessWidget {
  final Customer customer;

  const CustomerItem({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        KayleeInkwell(
          child: KayleeCartView(
              itemHeight: double.infinity,
              child: KayleeImageInfoLayout(
                imageView: KayleeNetworkImage.normal(
                  customer.image ?? '',
                  fit: BoxFit.cover,
                ),
                infoView: Padding(
                  padding: const EdgeInsets.only(top: Dimens.px16),
                  child: KayleeText.hyper16W500(
                    customer.name ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          onTap: () {
            context.push(PageIntent(
                screen: CreateNewCustomerScreen,
                bundle: Bundle(NewCustomerScreenData(
                    openFrom: CustomerScreenOpenFrom.customerListItem,
                    customer: customer))));
          },
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
