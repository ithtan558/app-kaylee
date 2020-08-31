import 'dart:math';

import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleeFilterView extends StatefulWidget {
  final Widget child;
  final String title;
  final KayleeFloatButton floatingActionButton;

  KayleeFilterView({this.title, this.child, this.floatingActionButton});

  @override
  _KayleeFilterViewState createState() => new _KayleeFilterViewState();
}

class _KayleeFilterViewState extends BaseState<KayleeFilterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: Dimens.px80 - Dimens.px8,
            child: SafeArea(
              top: true,
              child: widget.child ?? Container(),
            ),
          ),
          if (widget.floatingActionButton.isNotNull)
            Positioned(
              child: widget.floatingActionButton,
              right: Dimens.px24,
              bottom: Dimens.px24,
            ),
          Positioned(
            left: Dimens.px16,
            top: Dimens.px24,
            right: Dimens.px61 + Dimens.px16 * 2,
            child: SafeArea(
              top: true,
              child: KayleeText.normal26W700(
                widget.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatefulWidget {
  final void Function(bool state) onClick;
  final AnimationController animController;

  _FilterButton({this.onClick, this.animController});

  @override
  __FilterButtonState createState() => __FilterButtonState();
}

class __FilterButtonState extends BaseState<_FilterButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    widget.animController.addListener(() {
      if (widget.animController.isDismissed) {
        isOpened = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.px32,
      child: Material(
        borderRadius: BorderRadius.circular(Dimens.px5),
        color: ColorsRes.filterButton,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            if (!isOpened)
              widget.animController.forward(from: widget.animController.value);
            else
              widget.animController.reverse(from: widget.animController.value);
            isOpened = !isOpened;
            if (widget.onClick != null) {
              widget.onClick(isOpened);
            }
          },
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimens.px10),
                child: Image.asset(
                  Images.ic_options,
                  width: Dimens.px16,
                  height: Dimens.px16,
                ),
              ),
              Container(
                  width: Dimens.px1,
                  margin: const EdgeInsets.symmetric(vertical: Dimens.px2),
                  decoration: BoxDecoration(color: Colors.white)),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimens.px4),
                child: AnimatedBuilder(
                  animation: widget.animController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: widget.animController.value * pi,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    Images.ic_triangle_down,
                    width: Dimens.px24,
                    height: Dimens.px24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterView extends StatefulWidget {
  final String title;

  _FilterView({this.title});

  @override
  _FilterViewState createState() => new _FilterViewState();
}

class _FilterViewState extends BaseState<_FilterView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: <Widget>[],
      ),
    );
  }
}
