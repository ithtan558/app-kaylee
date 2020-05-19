import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/images.dart';
import 'package:kaylee/res/src/strings.dart';

class PolicyCheckBox extends StatefulWidget {
  @override
  _PolicyCheckBoxState createState() => _PolicyCheckBoxState();
}

class _PolicyCheckBoxState extends BaseState<PolicyCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = theme.textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
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
            child: Text.rich(TextSpan(
                text: 'Tôi đồng ý mọi',
                style:
                    textTheme.bodyText2.copyWith(fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                      text: ' điều khoản và quy định ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showSheet();
                        },
                      style: textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w400, color: ColorsRes.hyper)),
                  TextSpan(
                      text: 'khi sử dụng ứng dụng Kaylee',
                      style: textTheme.bodyText2
                          .copyWith(fontWeight: FontWeight.w400))
                ])),
          ),
        )
      ],
    );
  }

  void _showSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.px5),
                topRight: Radius.circular(Dimens.px5))),
        enableDrag: false,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (c) {
          return GestureDetector(
            onTap: () {
              pop(PageIntent(context, null));
            },
            child: Container(
              color: Colors.transparent,
              child: DraggableScrollableSheet(
                maxChildSize: 0.90,
                builder: (c, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimens.px5),
                      boxShadow: [
                        const BoxShadow(
                            color: Color(0x4c000000),
                            offset: Offset.zero,
                            blurRadius: Dimens.px20,
                            spreadRadius: 0)
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                            width: scaleWidth(Dimens.px37),
                            height: Dimens.px5,
                            margin: const EdgeInsets.symmetric(
                                vertical: Dimens.px16),
                            decoration: BoxDecoration(
                                color: ColorsRes.textFieldBorder,
                                borderRadius:
                                    BorderRadius.circular(Dimens.px3))),
                        Text(Strings.dieuKhoanVaDieuKien,
                            style: theme.textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: Dimens.px16),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              padding: const EdgeInsets.only(
                                  left: Dimens.px16,
                                  right: Dimens.px16,
                                  bottom: Dimens.px16),
                              child: Text(
                                Strings.policyContent,
                                style: theme.textTheme.bodyText2.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
        barrierColor: ColorsRes.dialogDimBg);
  }
}
