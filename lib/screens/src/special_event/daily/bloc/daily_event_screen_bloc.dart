import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';

class DailyEventScreenBloc extends Cubit<LoadMoreModel<Product>>
    with PaginationMixin<Product> {
  final AdvertiseRepository _advertiseRepository;

  DailyEventScreenBloc({required AdvertiseRepository advertiseRepository})
      : _advertiseRepository = advertiseRepository,
        super(LoadMoreModel()) {
    page = 1;
  }

  @override
  void load() {
    super.load();
    state.loading = true;
    RequestHandler(
      request: _advertiseRepository.getProductsOfDaily(
        limit: limit,
        page: page,
      ),
      onSuccess: ({message, result}) {
        final product = (result as PageData<Product>).items;
        addMore(nextItems: product);
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(product)
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
}
