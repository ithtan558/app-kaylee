import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';

class HotEventScreenBloc extends Cubit<LoadMoreModel<Content>>
    with PaginationMixin<Content> {
  final AdvertiseRepository _advertiseRepository;

  HotEventScreenBloc({required AdvertiseRepository advertiseRepository})
      : _advertiseRepository = advertiseRepository,
        super(LoadMoreModel()) {
    page = 1;
  }

  @override
  void load() {
    super.load();
    state.loading = true;
    RequestHandler(
      request: _advertiseRepository.getHotEvents(
        limit: limit,
        page: page,
      ),
      onSuccess: ({message, result}) {
        final product = (result as PageData<Content>).items;
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
