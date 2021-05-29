import 'dart:math';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeFloatButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String? icon;
  final Widget? iconWidget;

  KayleeFloatButton({this.onTap, this.icon, this.iconWidget});

  @override
  _KayleeFloatButtonState createState() => _KayleeFloatButtonState();
}

class _KayleeFloatButtonState extends State<KayleeFloatButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  Offset? currentLocalPoint;

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
  void _onTap(Offset? offset) {
    if (offset == null) return;
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

  void _onDragUpdate(Offset? offset) {
    if (offset == null) return;
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
              (widget.icon != null
                  ? ImageIcon(
                      AssetImage(
                        widget.icon!,
                      ),
                      color: ColorsRes.button,
                      size: Dimens.px16,
                    )
                  : Icon(
                      Icons.add,
                      color: ColorsRes.button,
                      size: Dimens.px24,
                    ))
        ]),
      ),
    );
  }
}

class KayleeMenuFloatButton extends StatefulWidget {
  final MenuFloatItem? mainItem;
  final MenuFloatItem? secondItem;

  KayleeMenuFloatButton({this.mainItem, this.secondItem});

  @override
  _KayleeMenuFloatButtonState createState() => _KayleeMenuFloatButtonState();
}

class _KayleeMenuFloatButtonState extends BaseState<KayleeMenuFloatButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> secondBtnAnim;
  late Animation<double> _label2Animation;
  late Animation<double> _label1Animation;

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    secondBtnAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animController, curve: Interval(0.3, 0.8)));
    _label2Animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animController, curve: Interval(0.2, 1)));
    _label1Animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _label2Animation, curve: Interval(0.5, 1)));
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (animController.isDismissed)
          return true;
        else {
          animController.reverse();
          return false;
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: animController,
              builder: (context, child) {
                if (animController.isDismissed)
                  return Container();
                else
                  return Opacity(
                    opacity: animController.value,
                    child: child,
                  );
              },
              child: GestureDetector(
                onTap: () {
                  if (animController.isCompleted) {
                    animController.reverse();
                  }
                },
                child: Container(
                  color: ColorsRes.dialogDimBg,
                ),
              ),
            ),
          ),
          Positioned(
            right: Dimens.px32,
            bottom: Dimens.px32, //24+8
            child: AnimatedBuilder(
              animation: secondBtnAnim,
              builder: (context, child) {
                final value = secondBtnAnim.value;
                return Container(
                  width: Dimens.px40,
                  height: Dimens.px40,
                  margin: const EdgeInsets.only(bottom: Dimens.px64),
                  alignment: Alignment.center,
                  child: Transform.scale(
                      alignment: Alignment.center,
                      scale: value,
                      child: Opacity(opacity: value, child: child)),
                );
              },
              child: Material(
                type: MaterialType.circle,
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    animController.reverse();
                    Future.delayed(Duration(milliseconds: 50), () {
                      widget.secondItem?.onTap?.call();
                    });
                  },
                  child: Center(
                    child: ImageIcon(
                      AssetImage(Images.ic_list),
                      color: ColorsRes.hintText,
                      size: Dimens.px16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Dimens.px96,
            right: Dimens.px24,
            child: AnimatedBuilder(
              animation: _label1Animation,
              builder: (context, child) {
                final value = _label1Animation.value;
                if (_label1Animation.isDismissed) return Container();
                return Container(
                  margin: EdgeInsets.only(
                      right: Dimens.px28 + (Dimens.px28 + Dimens.px16) * value),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: _buildLabel(
                title: widget.secondItem?.title ?? '',
                onTap: () {
                  animController.reverse();
                  Future.delayed(Duration(milliseconds: 50), () {
                    widget.secondItem?.onTap?.call();
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: Dimens.px32,
            right: Dimens.px24,
            child: AnimatedBuilder(
              animation: _label2Animation,
              builder: (context, child) {
                final value = _label2Animation.value;
                if (_label2Animation.isDismissed) return Container();
                return Container(
                  margin: EdgeInsets.only(
                      right: Dimens.px28 + (Dimens.px28 + Dimens.px16) * value),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: _buildLabel(
                title: widget.mainItem?.title ?? '',
                onTap: () {
                  animController.reverse();
                  Future.delayed(Duration(milliseconds: 50), () {
                    widget.mainItem?.onTap?.call();
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: Dimens.px24,
            right: Dimens.px24,
            child: KayleeFloatButton(
              onTap: () {
                if (animController.isCompleted) {
                  animController.reverse();
                  Future.delayed(Duration(milliseconds: 50), () {
                    widget.mainItem?.onTap?.call();
                  });
                } else {
                  animController.forward();
                }
              },
              iconWidget: AnimatedBuilder(
                animation: animController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: pi * animController.value,
                    child: animController.isCompleted
                        ? Icon(
                            Icons.add,
                            size: Dimens.px24,
                            color: ColorsRes.button,
                          )
                        : ImageIcon(
                            AssetImage(Images.ic_menu),
                            size: Dimens.px16,
                            color: ColorsRes.button,
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel({required String title, VoidCallback? onTap}) {
    return Material(
      borderRadius: BorderRadius.circular(Dimens.px5),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
              .copyWith(top: Dimens.px11, bottom: Dimens.px10),
          child: KayleeText.normal16W500(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }
}

class MenuFloatItem {
  final String? title;
  final VoidCallback? onTap;

  MenuFloatItem({this.title, this.onTap});
}
