import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/pagination_refresh_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginationRefreshGridView<Model> extends StatefulWidget {
  final PaginationRefreshInterface<Model> controller;
  final AsyncCallback? onRefresh;
  final EdgeInsets padding;

  final ScrollController? scrollController;

  final PaginationListItemBuilder<Model> itemBuilder;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  final WidgetBuilder? loadingIndicatorBuilder;

  final bool showInitialLoadingEffectItem;
  final IndexedWidgetBuilder? loadingEffectItemBuilder;
  final ScrollPhysics? physics;

  const PaginationRefreshGridView(
      {Key? key,
      required this.controller,
      required this.itemBuilder,
      required this.gridDelegate,
      this.onRefresh,
      this.padding = EdgeInsets.zero,
      this.scrollController,
      this.loadingIndicatorBuilder,
      this.showInitialLoadingEffectItem = false,
      this.loadingEffectItemBuilder,
      this.physics})
      : super(key: key);

  @override
  _PaginationRefreshGridViewState<Model> createState() =>
      _PaginationRefreshGridViewState<Model>();
}

class _PaginationRefreshGridViewState<Model>
    extends State<PaginationRefreshGridView<Model>> {
  @override
  Widget build(BuildContext context) {
    return PullDownRefreshWidget(
      controller: widget.controller,
      onRefresh: widget.onRefresh,
      child: PaginationGridView<Model>(
        controller: widget.controller,
        itemBuilder: widget.itemBuilder,
        gridDelegate: widget.gridDelegate,
        showInitialLoadingEffectItem: widget.showInitialLoadingEffectItem,
        scrollController: widget.scrollController,
        padding: widget.padding,
        loadingIndicatorBuilder: widget.loadingIndicatorBuilder,
        loadingEffectItemBuilder: widget.loadingEffectItemBuilder,
        physics: widget.physics,
      ),
    );
  }
}
