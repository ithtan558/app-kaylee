import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeFloatButton extends StatefulWidget {
  final void Function() onTap;

  KayleeFloatButton({this.onTap});

  @override
  _KayleeFloatButtonState createState() => _KayleeFloatButtonState();
}

class _KayleeFloatButtonState extends State<KayleeFloatButton>
    with SingleTickerProviderStateMixin {
  AnimationController animController;

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
        onLongPressEnd: (detail) {
          animController.reverse(from: animController.value);
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
          const Icon(
            Icons.add,
            color: ColorsRes.button,
            size: Dimens.px24,
          )
        ]),
      ),
    );
  }
}
