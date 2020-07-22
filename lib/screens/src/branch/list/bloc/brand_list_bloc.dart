import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class BrandListBloc extends Cubit<LoadMoreModel<Brand>>
    implements LoadMoreInterface {
  BrandService brandService;

  BrandListBloc({this.brandService}) : super(LoadMoreModel());

  String _keyword;
  int _cityId;
  String _districtIds;

  void loadBrands({String keyword, int cityId, String districtIds}) {
    _keyword = keyword;
    _cityId = cityId;
    _districtIds = districtIds;
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: brandService?.getBrands(
        keyword: _keyword,
        cityId: _cityId,
        districtIds: _districtIds,
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final brands = (result as Brands).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(brands)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
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
    loadBrands(
      keyword: _keyword,
      cityId: _cityId,
      districtIds: _districtIds,
    );
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;
}
