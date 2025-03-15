import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeFilterView extends StatefulWidget {
  final Widget? child;
  final String? title;
  final Widget? action;
  final KayleeFloatButton? floatingActionButton;

  const KayleeFilterView({
    Key? key,
    this.title,
    this.child,
    this.floatingActionButton,
    this.action,
  }) : super(key: key);

  @override
  _KayleeFilterViewState createState() => _KayleeFilterViewState();
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
          if (widget.floatingActionButton != null)
            Positioned(
              child: widget.floatingActionButton!,
              right: Dimens.px24,
              bottom: Dimens.px24,
            ),
          Positioned(
            left: Dimens.px16,
            top: Dimens.px24,
            right: 0,
            child: SafeArea(
              top: true,
              child: Row(
                children: [
                  Expanded(
                    child: KayleeText.normal26W700(
                      widget.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (widget.action.isNotNull) widget.action!
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
