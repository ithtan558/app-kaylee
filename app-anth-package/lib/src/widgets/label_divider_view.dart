import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class LabelDividerView extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Widget? ending;
  final Color? bgColor;

  const LabelDividerView(
      {Key? key, this.title, this.ending, this.bgColor, this.child})
      : super(key: key);

  factory LabelDividerView.normal({String? title, Color? bgColor}) =>
      LabelDividerView(
        title: title,
        bgColor: bgColor,
      );

  factory LabelDividerView.withButton(
          {String? title, String? buttonText, VoidCallback? onPress}) =>
      LabelDividerView(
        title: title,
        ending: Padding(
          padding: const EdgeInsets.only(right: Dimens.px4),
          child: KayleeFlatButton.withLabelDivider(
            title: buttonText,
            onPress: onPress,
          ),
        ),
      );

  factory LabelDividerView.monthYear({required DateTime time}) {
    final dateString = 'Tháng ' +
        DateFormat('${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}')
            .format(time);
    return LabelDividerView(
      title: dateString,
      bgColor: ColorsRes.labelDivider1,
    );
  }

  factory LabelDividerView.monthYearRange({required DateTimeRange range}) {
    final isSameMonth = range.start.month == range.end.month;
    final startDateString = 'Tháng ' +
        DateFormat(
                '${DateFormat.NUM_MONTH * 2}${isSameMonth ? '/${DateFormat.YEAR * 4}' : ''}')
            .format(range.start);
    String endDateString = isSameMonth
        ? ''
        : ' ~> ' +
            DateFormat('${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}')
                .format(range.end);

    return LabelDividerView(
      child: KayleeText.normal16W500(
        (startDateString) + (endDateString),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      bgColor: ColorsRes.labelDivider1,
    );
  }

  factory LabelDividerView.hyperLink(
          {String? title, String? linkText, VoidCallback? onPress}) =>
      LabelDividerView(
        title: title,
        ending: Padding(
          padding: const EdgeInsets.only(right: Dimens.px16),
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
      color: bgColor ?? ColorsRes.labelDivider,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimens.px16,
                  right: ending.isNotNull ? Dimens.px8 : Dimens.px16),
              child: child ??
                  KayleeText.normal16W500(
                    title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
          if (ending != null) ending!
        ],
      ),
    );
  }
}
