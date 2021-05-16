import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ServiceFilter extends Filter {
  int? startPrice;
  int? endPrice;
  ServiceCate? category;
  Brand? brand;
}

class ServiceListBloc extends Cubit<LoadMoreModel<Service>>
    with PaginationMixin<Service>
    implements KayleeFilterInterface<ServiceFilter> {
  final ServService servService;
  int cateId;
  ServiceFilter _filter;

  ///phải set [LoadMoreModel.items] = empty vì lúc init screen, phải chờ load category trước,
  ///thì lúc này KayleeGridView phải ẩn loading indicator đi
  ServiceListBloc({@required this.servService})
      : super(LoadMoreModel(items: [])) {
    page = 1;
  }

  @override
  void load() {
    super.load();
    RequestHandler(
      request: servService.getServices(
        categoryId: this.cateId,
        limit: limit,
        page: page,
        keyword: getFilter()?.keyword,
        brandIds: getFilter()?.brand?.id?.toString(),
        startPrice: getFilter()?.startPrice,
        endPrice: getFilter()?.endPrice,
      ),
      onSuccess: ({message, result}) {
        final services = (result as PageData<Service>).items;
        addMore(nextItems: services);
        emit(state.success());
      },
      onFailed: (code, {error}) {
        completeLoading();
        emit(state.failure(code: code, error: error));
      },
    );
  }

  void loadInitDataWithCate({int cateId}) {
    if (cateId.isNotNull) {
      changeTab(cateId: cateId);
    }
  }

  void changeTab({int cateId}) {
    if (loading) return;
    if (cateId.isNotNull) {
      ///user đổi category
      this.cateId = cateId;

      //reset page và item về ban đầu
      reset();
      emit(LoadMoreModel.copy(state
        ..loading = true
        ..page = 1
        ..items = null));
      load();
    }
  }

  @override
  ServiceFilter getFilter() => _filter;

  @override
  bool get isEmptyFilter => _filter == null;

  @override
  void loadFilter() {
    reset();
    emit(LoadMoreModel.copy(state
      ..items = null
      ..page = 1));
    load();
  }

  @override
  void resetFilter() {
    _filter = null;
  }

  @override
  ServiceFilter updateFilter() {
    if (isEmptyFilter) _filter = ServiceFilter();
    return _filter;
  }
}
