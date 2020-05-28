import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';

class KayleeProdItem extends StatefulWidget {
  @override
  _KayleeProdItemState createState() => new _KayleeProdItemState();
}

class _KayleeProdItemState extends BaseState<KayleeProdItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.px10),
        boxShadow: [
          BoxShadow(
              color: ColorsRes.shadow,
              offset: Offset(0, 1),
              blurRadius: 5,
              spreadRadius: 0)
        ],
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.px10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                'https://img.jakpost.net/c/2019/12/09/2019_12_09_83333_1575827116._large.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KayleeText.normal16W500(
                    'Tóc kiểu thôn nữ',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimens.px4),
                    child: KayleePriceText.normal(
                      600000,
                      textStyle: TextStyles.hyper16W400,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
