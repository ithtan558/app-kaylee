
import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

class KayleeFilterView extends StatefulWidget {
  final Widget? child;
  final String? title;
  final KayleeFloatButton? floatingActionButton;

  const KayleeFilterView(
      {Key? key, this.title, this.child, this.floatingActionButton})
      : super(key: key);

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


class _FilterView extends StatefulWidget {
  final String? title;

  const _FilterView({this.title});

  @override
  _FilterViewState createState() => _FilterViewState();
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
        children: const [],
      ),
    );
  }
}
