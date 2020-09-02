import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeFloatButton extends StatefulWidget {
  final VoidCallback onTap;
  final String icon;
  final Widget iconWidget;

  KayleeFloatButton({this.onTap, this.icon, this.iconWidget});

  @override
  _KayleeFloatButtonState createState() => _KayleeFloatButtonState();
}

class _KayleeFloatButtonState extends State<KayleeFloatButton>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Offset currentLocalPoint;

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  ///tính toạ độ của finger
  ///chỉ onTap khi toạ độ (x,y) nằm trong khoảng từ (0,0) -> (56,56)
  void _onTap(Offset offset) {
    if (offset.isNull) return;
    final dx = offset.dx;
    final dy = offset.dy;
    if (dx >= 0 &&
        dy <= Dimens.px56 &&
        dy >= 0 &&
        dy <= Dimens.px56 &&
        !animController.isDismissed) {
      widget.onTap?.call();
    }
  }

  void _onDragUpdate(Offset offset) {
    if (offset.isNull) return;
    final dx = offset.dx;
    final dy = offset.dy;
    if (dx <= 0 ||
        dy <= 0 ||
        dx >= Dimens.px56 ||
        dy >= Dimens.px56 && !animController.isAnimating) {
      animController.reverse(from: animController.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      type: MaterialType.circle,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (detail) {
          animController.forward(from: animController.value);
        },
        onTapUp: (detail) {
          animController.reverse(from: animController.value);
        },
        onLongPressMoveUpdate: (details) {
          // print('[TUNG] ===> onLongPressMoveUpdate');
          _onDragUpdate(details.localPosition);
        },
        onLongPressEnd: (details) {
          // print('[TUNG] ===> onLongPressEnd');
          animController.reverse(from: animController.value);
          _onTap(details.localPosition);
        },
        onPanUpdate: (details) {
          // print('[TUNG] ===> onPanUpdate');
          currentLocalPoint = details.localPosition;
          _onDragUpdate(currentLocalPoint);
        },
        onPanEnd: (details) {
          // print('[TUNG] ===> onPanEnd');
          animController.reverse(from: animController.value);
          _onTap(currentLocalPoint);
        },
        child: Stack(alignment: Alignment.center, children: [
          Container(
            height: Dimens.px56,
            width: Dimens.px56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                    color: ColorsRes.shadow.withOpacity(0.2),
                    offset: const Offset(Dimens.px5, Dimens.px5),
                    blurRadius: Dimens.px10,
                    spreadRadius: 0)
              ],
            ),
          ),
          AnimatedBuilder(
            animation: animController,
            builder: (c, child) {
              return Transform.scale(
                scale:
                    1 + animController.value * (1 - Dimens.px46 / Dimens.px50),
                child: child,
              );
            },
            child: Container(
              height: Dimens.px46,
              width: Dimens.px46,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
            ),
          ),
          widget.iconWidget ??
              Icon(
                widget.icon ?? Icons.add,
                color: ColorsRes.button,
                size: Dimens.px24,
              )
        ]),
      ),
    );
  }
}
