import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class KayleeTabView extends StatefulWidget {
  final KayleeAppBar appBar;
  final Widget body;
  final Widget floatingActionButton;

  KayleeTabView({this.appBar, this.body, this.floatingActionButton});

  @override
  _KayleeTabViewState createState() => _KayleeTabViewState();
}

class _KayleeTabViewState extends BaseState<KayleeTabView>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimens.px16, top: Dimens.px16, bottom: Dimens.px16),
            child: TabBar(
              tabs: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.px5),
                      color: Colors.transparent,
                      border: Border.fromBorderSide(
                          BorderSide(color: ColorsRes.textFieldBorder))),
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.px8, vertical: Dimens.px11),
                  child: KayleeText.hyper16W400(
                    'Phụ kiện cưới',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                ),
                KayleeText.hyper16W400(
                  'Phụ kiện cưới',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
                KayleeText.hyper16W400(
                  'Phụ kiện cưới',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
                KayleeText.hyper16W400(
                  'Phụ kiện cưới',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
                KayleeText.hyper16W400(
                  'Phụ kiện cưới',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
              ],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              labelPadding: EdgeInsets.zero,
              indicatorPadding: const EdgeInsets.only(left: Dimens.px8),
              indicatorWeight: 1,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.px5),
                  color: Colors.transparent,
                  border: Border.fromBorderSide(
                      BorderSide(color: ColorsRes.hyper))),
            ),
          ),
          Expanded(
              child: Stack(
            children: [
              widget.body ??
                  Container(
                    color: Colors.transparent,
                  ),
              Positioned(
                child: widget.floatingActionButton ?? Container(),
                right: Dimens.px24,
                bottom: Dimens.px24,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
