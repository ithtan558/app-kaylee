import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class StaffItem extends StatelessWidget {
  final void Function() onTap;
  final Employee employee;

  StaffItem({this.onTap, this.employee});

  @override
  Widget build(BuildContext context) {
    return KayleeInkwell(
      child: KayleeCartView(
          itemHeight: double.infinity,
          child: KayleeImageInfoLayout(
            imageView: Image.network(
              employee?.image ?? '',
              fit: BoxFit.cover,
            ),
            infoView: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KayleeText.hyper16W500(
                  (employee?.lastName.isNull ? '' : employee.lastName + ' ') +
                      (employee?.firstName ?? ''),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.px4),
                  child: KayleeText.hint16W400(
                    employee?.role?.name ?? '',
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
