import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/pagination_interface.dart';
import 'package:core_plugin/src/pagination/src/view/mixin/pagination_view_mixin.dart';
import 'package:flutter/material.dart';

///only used for vertical ListView
class PaginationListView<Model> extends StatefulWidget {
  final PaginationInterface<Model> controller;
  final EdgeInsets padding;

  ///pass into if you want to control another things exclude pagination
  final ScrollController? scrollController;

  ///build your main item
  final PaginationListItemBuilder<Model> itemBuilder;

  final IndexedWidgetBuilder? separatorBuilder;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;

  /// if you wanna show loading effect item
  /// default is false
  /// and you need to pass [loadingEffectItemBuilder]
  final bool showInitialLoadingEffectItem;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder? loadingEffectItemBuilder;
  final ScrollPhysics? physics;

  const PaginationListView({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.separatorBuilder,
    this.scrollController,
    this.loadingIndicatorBuilder,
    this.padding = EdgeInsets.zero,
    this.showInitialLoadingEffectItem = false,
    this.loadingEffectItemBuilder,
    this.physics,
  })  : assert(
            !showInitialLoadingEffectItem || loadingEffectItemBuilder != null,
            '\nyou have to pass `loadingEffectItemBuilder` if you set `showInitialLoadingEffectItem` = true '),
        super(key: key);

  @override
  _PaginationListViewState<Model> createState() =>
      _PaginationListViewState<Model>();
}

class _PaginationListViewState<Model> extends State<PaginationListView<Model>>
    with PaginationViewMixin<Model, PaginationListView<Model>> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: internalScrollController,
        physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
        padding: widget.padding,
        itemBuilder: (context, index) {
          //build loading effect (có thể là shimmer)
          if (showInitialLoadingEffectItem) {
            return buildLoadingEffectItem(
                loadingEffectItem:
                    widget.loadingEffectItemBuilder?.call(context, index));
          }

          //build bottom loading indicator
          if (index == loadingIndicatorIndex) {
            return buildBottomLoadingIndicator(
                loadingIndicator:
                    widget.loadingIndicatorBuilder?.call(context));
          }

          ///build item
          return widget.itemBuilder
              .call(context, index, controller.items!.elementAt(index));
        },
        separatorBuilder: (context, index) =>
            widget.separatorBuilder?.call(context, index) ??
            const SizedBox.shrink(),
        itemCount: itemCount!);
  }

  @override
  int? get itemCount {
    if (super.itemCount.isNull) {
      return controller.items!.length + (!controller.ended ? 1 : 0);
    }
    return super.itemCount;
  }

  @override
  bool get showInitialLoadingEffectItem => widget.showInitialLoadingEffectItem;

  @override
  ScrollController? get externalScrollController => widget.scrollController;

  @override
  PaginationInterface<Model> get controller => widget.controller;
}
