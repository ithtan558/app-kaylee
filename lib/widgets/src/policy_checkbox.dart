import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/images.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class PolicyCheckBox extends StatefulWidget {
  final ValueSetter<bool> onChecked;

  PolicyCheckBox({this.onChecked});

  @override
  _PolicyCheckBoxState createState() => _PolicyCheckBoxState();
}

class _PolicyCheckBoxState extends BaseState<PolicyCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
            if (widget.onChecked.isNotNull) widget.onChecked(isChecked);
          },
          child: Image.asset(
            isChecked ? Images.ic_checked : Images.ic_notcheck,
            width: Dimens.px24,
            height: Dimens.px24,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: Dimens.px10),
            child: Text.rich(TextSpan(text: 'Tôi đồng ý mọi', children: [
              TextSpan(
                  text: ' điều khoản và quy định ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showKayleeBottomSheet(context,
                          maxChildSize: 635 / 667, initialChildSize: 635 / 667,
                          builder: (context, scrollController) {
                        return Column(
                          children: [
                            KayleeText.normal16W500(
                              Strings.dieuKhoanVaDieuKien.toUpperCase(),
                              overflow: TextOverflow.visible,
                              maxLines: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: Dimens.px16),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  padding: const EdgeInsets.only(
                                      left: Dimens.px16,
                                      right: Dimens.px16,
                                      bottom: Dimens.px16),
                                  child: KayleeText.normal16W400(
                                    Strings.policyContent,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                    },
                  style: TextStyles.hyper16W400),
              TextSpan(text: 'khi sử dụng ứng dụng Kaylee')
            ])),
          ),
        )
      ],
    );
  }
}
