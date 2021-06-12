import 'package:anth_package/anth_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class StaffItem extends StatelessWidget {
  final VoidCallback onTap;
  final Employee employee;

  StaffItem({required this.onTap, required this.employee});

  @override
  Widget build(BuildContext context) {
    return KayleeInkwell(
      child: KayleeCartView(
          itemHeight: double.infinity,
          child: KayleeImageInfoLayout(
            imageView: CachedNetworkImage(
              imageUrl: employee.image ?? '',
              fit: BoxFit.cover,
            ),
            infoView: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KayleeText.hyper16W500(
                  employee.name ?? '',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.px4),
                  child: KayleeText.hint16W400(
                    employee.role?.name ?? '',
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
