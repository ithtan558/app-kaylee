import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/pagination_interface.dart';
import 'package:core_plugin/src/pagination/src/view/mixin/pagination_view_mixin.dart';
import 'package:flutter/material.dart';

///only used for vertical GridView
class PaginationGridView<Model> extends StatefulWidget {
  final PaginationInterface<Model> controller;
  final EdgeInsets padding;

  ///pass into if you want to control another things exclude pagination
  final ScrollController? scrollController;

  ///build your main item
  final PaginationListItemBuilder<Model> itemBuilder;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;

  /// if you wanna show loading effect item
  /// default is false
  /// and you need to pass [loadingEffectItemBuilder]
  final bool showInitialLoadingEffectItem;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder? loadingEffectItemBuilder;
  final ScrollPhysics? physics;

  const PaginationGridView(
      {Key? key,
      required this.controller,
      required this.itemBuilder,
      required this.gridDelegate,
      this.scrollController,
      this.loadingIndicatorBuilder,
      this.padding = EdgeInsets.zero,
      this.showInitialLoadingEffectItem = false,
      this.loadingEffectItemBuilder,
      this.physics})
      : assert(
            !showInitialLoadingEffectItem || loadingEffectItemBuilder != null,
            '\nyou have to pass `loadingEffectItemBuilder` if you set `showInitialLoadingEffectItem` = true '),
        super(key: key);

  @override
  _PaginationGridViewState<Model> createState() =>
      _PaginationGridViewState<Model>();
}

class _PaginationGridViewState<Model> extends State<PaginationGridView<Model>>
    with PaginationViewMixin<Model, PaginationGridView<Model>> {
  double get _itemRatio => widget.gridDelegate.childAspectRatio;

  double get _itemWidth {
    final paddingLeftOfGrid = widget.padding.left;
    final paddingRightOfGrid = widget.padding.right;
    final paddingBetweenItem = widget.gridDelegate.crossAxisSpacing *
        (widget.gridDelegate.crossAxisCount - 1);
    return (context.screenSize.width -
            (paddingLeftOfGrid + paddingRightOfGrid + paddingBetweenItem)) /
        widget.gridDelegate.crossAxisCount;
  }

  double get _itemHeight => _itemWidth / _itemRatio;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: internalScrollController,
        physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
        padding: widget.padding,
        itemBuilder: (context, gridViewItemIndex) {
          //build loading effect (có thể là shimmer)
          if (showInitialLoadingEffectItem) {
            return _buildItemsRow(
              builder: (index) {
                return widget.loadingEffectItemBuilder?.call(context, index) ??
                    const SizedBox.shrink();
              },
            );
          }

          //build bottom loading indicator
          if (gridViewItemIndex == loadingIndicatorIndex) {
            return buildBottomLoadingIndicator(
                loadingIndicator:
                    widget.loadingIndicatorBuilder?.call(context));
          }

          ///build items trên 1 row
          return _buildItemsRow(
            builder: (rowItemIndex) {
              //index thực tế của item trong list data
              final itemIndex =
                  widget.gridDelegate.crossAxisCount * gridViewItemIndex +
                      rowItemIndex;

              //[itemIndex] vẫn thuộc [controller.items];
              final isValidIndex = itemIndex < controller.items!.length;
              return isValidIndex
                  ? widget.itemBuilder(context, itemIndex,
                      controller.items!.elementAt(itemIndex))
                  : const SizedBox.shrink();
            },
          );
        },
        separatorBuilder: (context, index) =>
            SizedBox(height: widget.gridDelegate.mainAxisSpacing),
        itemCount: itemCount!);
  }

  ///build item trên 1 row của grid
  Widget _buildItemsRow({required Widget Function(int index) builder}) {
    return SizedBox(
      height: _itemHeight,
      child: Row(
        children:
            List.generate(widget.gridDelegate.crossAxisCount, (rowItemIndex) {
          //item cuôi cùng của 1 hàng
          final isLastItemInRow =
              rowItemIndex == widget.gridDelegate.crossAxisCount - 1;
          return Container(
              width: _itemWidth,
              height: _itemHeight,
              margin: isLastItemInRow
                  ? EdgeInsets.zero
                  : EdgeInsets.only(
                      right: widget.gridDelegate.crossAxisSpacing),
              child: builder.call(rowItemIndex));
        }),
      ),
    );
  }

  ///tính itemCount trong 2 trường hợp
  ///khi loading [showInitialLoadingEffectItem] =true: show shimmer khi loading lần đầu tiên
  ///khi chưa phải là page cuối cùng, thì cuối list cần phải show loading indicator
  @override
  int? get itemCount {
    if (super.itemCount.isNull) {
      return ((controller.items!.length / widget.gridDelegate.crossAxisCount)
              .ceil() +
          (!controller.ended ? 1 : 0));
    }
    return super.itemCount;
  }

  @override
  ScrollController? get externalScrollController => widget.scrollController;

  @override
  PaginationInterface<Model> get controller => widget.controller;

  @override
  bool get showInitialLoadingEffectItem => widget.showInitialLoadingEffectItem;
}
