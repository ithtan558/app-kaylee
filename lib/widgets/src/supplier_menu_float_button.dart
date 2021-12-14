import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class SupplierMenuFloatButton extends StatefulWidget {
  final MenuFloatItem? firstItem;
  final MenuFloatItem? secondItem;

  const SupplierMenuFloatButton({Key? key, this.firstItem, this.secondItem})
      : super(key: key);

  @override
  _SupplierMenuFloatButtonState createState() =>
      _SupplierMenuFloatButtonState();
}

class _SupplierMenuFloatButtonState extends BaseState<SupplierMenuFloatButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> secondBtnAnim;
  late Animation<double> firstBtnAnim;
  late Animation<double> _label1Animation;
  late Animation<double> _label2Animation;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    secondBtnAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animController, curve: const Interval(0.3, 0.8)));
    firstBtnAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animController, curve: const Interval(0.1, 0.6)));
    _label1Animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animController, curve: const Interval(0.2, 1)));
    _label2Animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _label1Animation, curve: const Interval(0.5, 1)));
  }

  final _mainButtonSize = Dimens.px56;
  final _mainBtnBottomPadding = Dimens.px24;

  double get _mainButtonSpace => _mainBtnBottomPadding + _mainButtonSize;

  double get _subBtnSize => Dimens.px40;

  double get _subBtnRightMargin => Dimens.px32;

  final _firstBtnBottomPadding = Dimens.px16;

  double get _firstButtonSpace => _firstBtnBottomPadding + _subBtnSize;

  final _secondBtnPadding = Dimens.px24;

  double get _labelRightMargin => Dimens.px24;

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
            right: _subBtnRightMargin,
            bottom: _mainButtonSpace + _firstButtonSpace + _secondBtnPadding,
            //24+8
            child: AnimatedBuilder(
              animation: secondBtnAnim,
              builder: (context, child) {
                final value = secondBtnAnim.value;
                return Transform.scale(
                    alignment: Alignment.center,
                    scale: value,
                    child: Opacity(opacity: value, child: child));
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
                  child: Center(
                    child: Image.asset(
                      Images.icZalo,
                      width: _subBtnSize,
                      height: _subBtnSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: _mainButtonSpace + _firstButtonSpace + _secondBtnPadding,
            right: _labelRightMargin,
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
            right: _subBtnRightMargin,
            bottom: _mainButtonSpace + _firstBtnBottomPadding, //24+8
            child: AnimatedBuilder(
              animation: firstBtnAnim,
              builder: (context, child) {
                final value = firstBtnAnim.value;
                return Transform.scale(
                    alignment: Alignment.center,
                    scale: value,
                    child: Opacity(opacity: value, child: child));
              },
              child: Material(
                type: MaterialType.circle,
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    animController.reverse();
                    Future.delayed(const Duration(milliseconds: 50), () {
                      widget.firstItem?.onTap?.call();
                    });
                  },
                  child: Center(
                    child: Image.asset(
                      Images.icMessenger,
                      width: _subBtnSize,
                      height: _subBtnSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: _mainButtonSpace + _firstBtnBottomPadding,
            right: _labelRightMargin,
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
                title: widget.firstItem?.title ?? '',
                onTap: () {
                  animController.reverse();
                  Future.delayed(const Duration(milliseconds: 50), () {
                    widget.firstItem?.onTap?.call();
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: _mainBtnBottomPadding,
            right: Dimens.px24,
            child: KayleeFloatButton(
              onTap: () {
                if (animController.isCompleted) {
                  animController.reverse();
                } else {
                  animController.forward();
                }
              },
              iconWidget: Container(
                height: _mainButtonSize,
                width: _mainButtonSize,
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
                child: Image.asset(Images.icMessage),
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
