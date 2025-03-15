import 'dart:math';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeMenuFloatButton extends StatefulWidget {
  final MenuFloatItem? mainItem;
  final MenuFloatItem? secondItem;

  const KayleeMenuFloatButton({Key? key, this.mainItem, this.secondItem})
      : super(key: key);

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
    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    secondBtnAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animController, curve: const Interval(0.3, 0.8)));
    _label2Animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animController, curve: const Interval(0.2, 1)));
    _label1Animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _label2Animation, curve: const Interval(0.5, 1)));
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
        if (animController.isDismissed) {
          return true;
        } else {
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
                if (animController.isDismissed) {
                  return Container();
                } else {
                  return Opacity(
                    opacity: animController.value,
                    child: child,
                  );
                }
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
                    Future.delayed(const Duration(milliseconds: 50), () {
                      widget.secondItem?.onTap?.call();
                    });
                  },
                  child: const Center(
                    child: ImageIcon(
                      AssetImage(IconAssets.icList, package: anthPackage),
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
                  Future.delayed(const Duration(milliseconds: 50), () {
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
                  Future.delayed(const Duration(milliseconds: 50), () {
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
                  Future.delayed(const Duration(milliseconds: 50), () {
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
                        ? const Icon(
                            Icons.add,
                            size: Dimens.px24,
                            color: ColorsRes.button,
                          )
                        : const ImageIcon(
                            AssetImage(IconAssets.icMenu, package: anthPackage),
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
