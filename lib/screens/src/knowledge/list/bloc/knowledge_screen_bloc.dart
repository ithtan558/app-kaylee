import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';

class KnowledgeListBloc extends Cubit<LoadMoreModel<Content>>
    with PaginationMixin<Content> {
  final KnowledgeRepository _knowledgeRepository;

  KnowledgeListBloc({required KnowledgeRepository knowledgeRepository})
      : _knowledgeRepository = knowledgeRepository,
        super(LoadMoreModel()) {
    page = 1;
  }

  @override
  void load() {
    super.load();
    state.loading = true;
    RequestHandler(
      request: _knowledgeRepository.getKnowledge(
        page: page,
        limit: limit,
      ),
      onSuccess: ({message, result}) {
        final knowledge = (result as PageData<Content>).items;
        addMore(nextItems: knowledge);
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(knowledge)
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        completeLoading();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  void loadInitData() {
    load();
  }
}
