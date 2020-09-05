import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class BrandFilter extends Filter {
  City city;
  District district;
}

class BrandListBloc extends Cubit<LoadMoreModel<Brand>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface, KayleeFilterInterface<BrandFilter> {
  BrandService brandService;

  BrandListBloc({this.brandService}) : super(LoadMoreModel());

  BrandFilter _filter;

  void loadBrands() {
    state.loading = true;
    RequestHandler(
      request: brandService?.getBrands(
        keyword: _filter?.keyword,
        cityId: _filter?.city?.id,
        districtIds: _filter?.district?.id?.toString(),
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final brands = (result as Brands).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(brands)
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

  @override
  void loadMore() {
    state.page++;
    loadBrands();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void loadFilter() {
    ///nếu có filter hoặc list item hiện tại đang empty
    if (loadFilterWhen) {
      state
        ..items = null
        ..page = 1;
      loadBrands();
    }
  }

  @override
  BrandFilter getFilter() {
    return _filter;
  }

  @override
  void resetFilter() {
    _filter = null;
  }

  @override
  bool get isEmptyFilter => _filter == null;

  @override
  BrandFilter updateFilter() {
    if (isEmptyFilter) _filter = BrandFilter();
    return _filter;
  }

  @override
  bool get loadFilterWhen => !isEmptyFilter || state.items.isNullOrEmpty;

  @override
  void loadInitData() {
    loadBrands();
  }

  @override
  void refresh() {
    super.refresh();
    state
      ..page = 1
      ..items = [];
    loadBrands();
  }
}
