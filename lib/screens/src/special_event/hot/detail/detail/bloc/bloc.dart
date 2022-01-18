import 'package:anth_package/anth_package.dart' hide Notification, Status;
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';

class HotEventDetailScreenBloc extends Cubit<SingleModel>
    implements CRUDInterface {
  final AdvertiseRepository _advertiseRepository;
  Content content;

  HotEventDetailScreenBloc(
      {required AdvertiseRepository advertiseRepository, required this.content})
      : _advertiseRepository = advertiseRepository,
        super(SingleModel());

  @override
  void create() {}

  @override
  void get() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: _advertiseRepository.getHotEventDetail(content.slug),
      onSuccess: ({message, result}) {
        emit(HotEventDetailModel.copy(state
          ..loading = false
          ..item = result
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void update() {}

  @override
  void delete() {}
}

class HotEventDetailModel extends SingleModel<Content> {
  HotEventDetailModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..message = old.message
      ..item = old.item;
  }
}
