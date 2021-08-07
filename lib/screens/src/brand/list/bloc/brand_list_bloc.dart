import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/models/models.dart';

class BrandFilter extends Filter {
  City? city;
  District? district;
}

class BrandListBloc extends Cubit<LoadMoreModel<Brand>>
    with PaginationMixin<Brand>
    implements KayleeFilterInterface<BrandFilter> {
  BrandService brandService;

  BrandListBloc({required this.brandService}) : super(LoadMoreModel()) {
    page = 1;
  }

  BrandFilter? _filter;

  @override
  void load() {
    super.load();
    state.loading = true;
    RequestHandler(
      request: brandService.getBrands(
        keyword: _filter?.keyword,
        cityId: _filter?.city?.id,
        districtIds: _filter?.district?.id?.toString(),
        limit: limit,
        page: page,
      ),
      onSuccess: ({message, result}) {
        final brands = (result as PageData<Brand>).items;
        addMore(nextItems: brands);
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(brands)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        completeLoading();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  @override
  void loadFilter() {
    reset();
    emit(LoadMoreModel.copy(state));
    load();
  }

  @override
  BrandFilter? getFilter() {
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
    return _filter!;
  }

  void loadInitData() {
    load();
  }
}
