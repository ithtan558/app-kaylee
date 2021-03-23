import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class RequestSettingDialog extends StatefulWidget {
  final String title;
  final String message;
  final String guides;
  final VoidCallback onGoToSetting;

  RequestSettingDialog({
    this.title,
    this.message,
    this.guides,
    this.onGoToSetting,
  });

  @override
  _RequestSettingDialogState createState() => _RequestSettingDialogState();
}

class _RequestSettingDialogState extends State<RequestSettingDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: Dimens.px24),
        if (widget.title.isNotNullAndEmpty)
          Padding(
            padding: const EdgeInsets.only(
              right: Dimens.px16,
              left: Dimens.px16,
              bottom: Dimens.px16,
            ),
            child: KayleeText.normal18W700(
              widget.title,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        if (widget.message.isNotNullAndEmpty)
          Padding(
            padding: const EdgeInsets.only(
                right: Dimens.px16, left: Dimens.px16, bottom: Dimens.px16),
            child: KayleeText.normal16W400(
              widget.message,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        if (widget.guides.isNotNullAndEmpty)
          Padding(
            padding: const EdgeInsets.only(
                right: Dimens.px16, left: Dimens.px16, bottom: Dimens.px16),
            child: KayleeText.normal16W400(
              widget.guides,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        Container(
          width: double.infinity,
          height: Dimens.px1,
          color: ColorsRes.divider,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
          child: Row(
            children: [
              Expanded(
                child: KayLeeRoundedButton.button2(
                  text: Strings.huy,
                  onPressed: context.pop,
                  margin: const EdgeInsets.only(
                      right: Dimens.px8, left: Dimens.px16),
                ),
              ),
              Expanded(
                child: KayLeeRoundedButton.normal(
                  text: Strings.caiDatNgay,
                  onPressed: () {
                    context.pop();
                    widget.onGoToSetting?.call();
                  },
                  margin: const EdgeInsets.only(
                      left: Dimens.px8, right: Dimens.px16),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
