import 'dart:math';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KayleeDateFilterButton extends StatefulWidget {
  final AsyncValueGetter<bool> onTap;
  final DateTime selectedDate;
  final Color? color;

  const KayleeDateFilterButton({
    Key? key,
    required this.selectedDate,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  _KayleeDateFilterButtonState createState() => _KayleeDateFilterButtonState();
}

class _KayleeDateFilterButtonState extends BaseState<KayleeDateFilterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeFlatButton.filter(
      background: widget.color,
      child: Row(children: [
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: KayleeText.normalWhite16W400(
            'Tháng ${DateFormat('${DateFormat.NUM_MONTH * 2}/${DateFormat.YEAR * 4}').format(widget.selectedDate)}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )),
        AnimatedBuilder(
          animation: animController,
          builder: (context, child) {
            return Transform.rotate(
                angle: pi * animController.value, child: child);
          },
          child: Image.asset(
            IconAssets.icTriangleDown,
            color: Colors.white,
            width: Dimens.px16,
            height: Dimens.px16,
            package: anthPackage,
          ),
        )
      ]),
      onPress: () async {
        if (animController.isDismissed) {
          animController.forward(from: animController.value);
        }
        final result = await widget.onTap();
        if (animController.isCompleted && result) {
          animController.reverse(from: animController.value);
        }
      },
    );
  }
}
