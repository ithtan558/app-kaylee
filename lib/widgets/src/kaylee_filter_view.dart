import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class KayleeFilterView extends StatefulWidget {
  final Widget child;
  final String title;

  KayleeFilterView({this.title, this.child});

  @override
  _KayleeFilterViewState createState() => new _KayleeFilterViewState();
}

class _KayleeFilterViewState extends BaseState<KayleeFilterView> {
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
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            top: true,
            child: Container(
              height: Dimens.px32,
              margin: const EdgeInsets.only(top: Dimens.px24),
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyText2.copyWith(
                        fontSize: Dimens.px26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorsRes.filterButton,
                        borderRadius: BorderRadius.circular(Dimens.px5)),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Dimens.px10),
                          child: Image.asset(
                            Images.ic_filter_down,
                            width: Dimens.px24,
                            height: Dimens.px24,
                          ),
                        ),
                        Container(
                            width: Dimens.px1,
                            margin: const EdgeInsets.symmetric(
                                vertical: Dimens.px2),
                            decoration: BoxDecoration(color: Colors.white)),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Dimens.px4),
                          child: Image.asset(
                            Images.ic_filter_down,
                            width: Dimens.px24,
                            height: Dimens.px24,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: widget.child ?? Container())
        ],
      ),
    );
  }
}
