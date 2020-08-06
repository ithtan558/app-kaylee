import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class BrandListBloc extends Cubit<LoadMoreModel<Brand>>
    implements LoadMoreInterface {
  BrandService brandService;

  BrandListBloc({this.brandService}) : super(LoadMoreModel());

  String _keyword;
  City _city;
  District _district;

  void loadBrands() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: brandService?.getBrands(
        keyword: _keyword,
        cityId: _city?.id,
        districtIds: _district?.id?.toString(),
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

  void loadFilter({String keyword, City city, District district}) {
    this
      .._keyword = keyword
      .._city = city
      .._district = district;
    loadBrands();
  }

  @override
  void loadMore() {
    state.page++;
    loadBrands();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;
}
