import 'package:anth_package/anth_package.dart' hide Notification, Status;
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';

class KnowledgeDetailScreenBloc extends Cubit<SingleModel<Content>>
    implements CRUDInterface {
  final KnowledgeRepository _knowledgeRepository;
  Content knowledge;

  KnowledgeDetailScreenBloc(
      {required KnowledgeRepository knowledgeRepository,
      required this.knowledge})
      : _knowledgeRepository = knowledgeRepository,
        super(SingleModel());

  @override
  void create() {}

  @override
  void get() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: _knowledgeRepository.getKnowledgeDetail(knowledge.slug),
      onSuccess: ({message, result}) {
        emit(KnowledgeDetailModel.copy(state
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

class KnowledgeDetailModel extends SingleModel<Content> {
  KnowledgeDetailModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..message = old.message
      ..item = old.item;
  }
}
