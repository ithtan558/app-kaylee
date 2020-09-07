import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ServiceFilter extends Filter {
  int startPrice;
  int endPrice;
  ServiceCate category;
  Brand brand;
}

class ServiceListBloc extends Cubit<LoadMoreModel<Service>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface, KayleeFilterInterface<ServiceFilter> {
  final ServService servService;
  int cateId;
  ServiceFilter _filter;

  ///phải set [LoadMoreModel.items] = empty vì lúc init screen, phải chờ load category trước,
  ///thì lúc này KayleeGridView phải ẩn loading indicator đi
  ServiceListBloc({@required this.servService})
      : super(LoadMoreModel(items: []));

  void loadServices() {
    RequestHandler(
      request: servService.getServices(
        categoryId: this.cateId,
        limit: state.limit,
        page: state.page,
        keyword: getFilter()?.keyword,
        brandIds: getFilter()?.brand?.id?.toString(),
        startPrice: getFilter()?.startPrice,
        endPrice: getFilter()?.endPrice,
      ),
      onSuccess: ({message, result}) {
        final services = (result as Services).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(services)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void loadInitDataWithCate({int cateId}) {
    if (cateId.isNotNull) {
      changeTab(cateId: cateId);
    }
  }

  void changeTab({int cateId}) {
    if (cateId.isNotNull) {
      ///user đổi category
      this.cateId = cateId;

      //reset page và item về ban đầu
      emit(LoadMoreModel.copy(state
        ..loading = true
        ..page = 1
        ..items = null));
      loadServices();
    }
  }

  @override
  void loadMore() {
    state.page++;
    loadServices();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  ServiceFilter getFilter() => _filter;

  @override
  bool get isEmptyFilter => _filter == null;

  @override
  void loadFilter() {
    if (loadFilterWhen) {
      emit(state
        ..items = null
        ..page = 1);
      loadServices();
    }
  }

  @override
  bool get loadFilterWhen => !isEmptyFilter || state.items.isNullOrEmpty;

  @override
  void resetFilter() {
    _filter = null;
  }

  @override
  ServiceFilter updateFilter() {
    if (isEmptyFilter) _filter = ServiceFilter();
    return _filter;
  }

  @override
  void refresh() {
    super.refresh();
    state
      ..page = 1
      ..items = []
      ..loading = true;
    loadServices();
  }
}
