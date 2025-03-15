import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/pagination_refresh_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef PaginationListItemBuilder<Model> = Widget Function(
    BuildContext context, int index, Model item);

class PaginationRefreshListView<Model> extends StatefulWidget {
  final PaginationRefreshInterface<Model> controller;
  final AsyncCallback? onRefresh;

  final EdgeInsets padding;

  final ScrollController? scrollController;

  final PaginationListItemBuilder<Model> itemBuilder;

  final IndexedWidgetBuilder? separatorBuilder;

  final WidgetBuilder? loadingIndicatorBuilder;

  final bool showInitialLoadingEffectItem;

  final IndexedWidgetBuilder? loadingEffectItemBuilder;
  final ScrollPhysics? physics;

  const PaginationRefreshListView({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
    this.scrollController,
    this.separatorBuilder,
    this.loadingIndicatorBuilder,
    this.showInitialLoadingEffectItem = false,
    this.loadingEffectItemBuilder,
    this.onRefresh,
    this.physics,
  }) : super(key: key);

  @override
  _PaginationRefreshListViewState<Model> createState() =>
      _PaginationRefreshListViewState<Model>();
}

class _PaginationRefreshListViewState<Model>
    extends State<PaginationRefreshListView<Model>> {
  @override
  Widget build(BuildContext context) {
    return PullDownRefreshWidget(
      controller: widget.controller,
      onRefresh: widget.onRefresh,
      child: PaginationListView<Model>(
        controller: widget.controller,
        itemBuilder: widget.itemBuilder,
        loadingEffectItemBuilder: widget.loadingEffectItemBuilder,
        loadingIndicatorBuilder: widget.loadingIndicatorBuilder,
        padding: widget.padding,
        scrollController: widget.scrollController,
        separatorBuilder: widget.separatorBuilder,
        showInitialLoadingEffectItem: widget.showInitialLoadingEffectItem,
        physics: widget.physics,
      ),
    );
  }
}
