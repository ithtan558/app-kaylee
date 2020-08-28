import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class LabelDividerView extends StatelessWidget {
  final String title;
  final Widget ending;

  LabelDividerView({this.title, this.ending});

  factory LabelDividerView.normal({String title}) =>
      LabelDividerView(title: title);

  factory LabelDividerView.withButton(
          {String title, String buttonText, VoidCallback onPress}) =>
      LabelDividerView(
        title: title,
        ending: Padding(
          padding: EdgeInsets.only(right: Dimens.px4),
          child: KayleeFlatButton.withLabelDivider(
            title: buttonText,
            onPress: onPress,
          ),
        ),
      );

  factory LabelDividerView.monthYear(int time) {
    final dateString = 'Tháng ' +
        DateFormat('${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}')
            .format(DateTime.fromMillisecondsSinceEpoch((time ?? 0) * 1000));
    return LabelDividerView(
      title: dateString,
    );
  }

  factory LabelDividerView.hyperLink(
          {String title, String linkText, Function onPress}) =>
      LabelDividerView(
        title: title,
        ending: Padding(
          padding: EdgeInsets.only(right: Dimens.px16),
          child: HyperLinkText(
            text: linkText,
            onTap: onPress,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px48,
      color: ColorsRes.labelDivider,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimens.px16,
                  right: ending.isNotNull ? Dimens.px8 : Dimens.px16),
              child: KayleeText(title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.normal16W500),
            ),
          ),
          if (ending.isNotNull) ending
        ],
      ),
    );
  }
}
