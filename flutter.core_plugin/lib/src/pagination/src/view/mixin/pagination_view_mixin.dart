import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/pagination_interface.dart';
import 'package:flutter/material.dart';

mixin PaginationViewMixin<Model, T extends StatefulWidget> on State<T> {
  ///override để lấy [widget.controller] đc truyền từ ngoài vào
  PaginationInterface<Model> get controller;

  ///default loading indicator
  final defaultLoadingIndicator = const Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    ),
  );

  ///override để tính chiều dài của list
  @mustCallSuper
  int? get itemCount {
    if (showInitialLoadingEffectItem) {
      return controller.limit;
    } else if (controller.isFirstTimeLoad ?? false) {
      return 1;
    } else if (controller.items.isNullOrEmpty) {
      return 0;
    }
    return null;
  }

  ///override để lấy [widget.showInitialLoadingEffectItem] đc truyền từ ngoài vào
  bool get showInitialLoadingEffectItem;

  ///override lại để lấy [ScrollController] truyền từ bên ngoài vào
  ///nếu ko thì [_internalScrollController] sẽ tự initialized ở [internalScrollController]
  ScrollController? get externalScrollController;

  /// NHỮNG FUNCTION KO CẦN PHẢI OVERRIDE (BEGIN)

  ///không cần phải override
  late ScrollController internalScrollController;

  /// NHỮNG FUNCTION KO CẦN PHẢI OVERRIDE (END)

  @override
  void initState() {
    super.initState();
    // print('[TUNG] ===> initState');
    (internalScrollController = externalScrollController ?? ScrollController())
        .addListener(() {
      // print('[TUNG] ===> ');
      if (internalScrollController.position.pixels >=
              internalScrollController.position.maxScrollExtent &&
          !internalScrollController.position.outOfRange) {
        // print('[TUNG] ===> nextPage');
        controller.nextPage();
      }
    });
  }

  @override
  void dispose() {
    //call disposing nếu controller ko đc truyền từ bên ngoài
    if (externalScrollController.isNull || internalScrollController.isNotNull) {
      internalScrollController.dispose();
    }
    super.dispose();
  }

  ///return indicator index trong các trường hợp
  ///khi list đã tới cuối và chưa tới cuối
  int get loadingIndicatorIndex {
    //khi tới cuối list, trả index = -1 để ko show indicator nữa
    if (controller.isFirstTimeLoad.isNull || controller.ended) return -1;
    //còn ko, index cuối cùng của ListView sẽ show indicator
    return itemCount! - 1;
  }

  //build bottom loading indicator
  Widget buildBottomLoadingIndicator({Widget? loadingIndicator}) {
    if (controller.refreshing) return const SizedBox.shrink();
    return loadingIndicator ?? defaultLoadingIndicator;
  }

  //build loading effect (có thể là shimmer)
  Widget buildLoadingEffectItem({Widget? loadingEffectItem}) {
    return loadingEffectItem ?? const SizedBox.shrink();
  }
}
