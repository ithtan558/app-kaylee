import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/src/knowledge/knowledge_repository.dart';
import 'package:kaylee/services/services.dart';

class KnowledgeRepositoryImpl extends KnowledgeRepository {
  final CommonService _commonService;

  KnowledgeRepositoryImpl({required CommonService commonService})
      : _commonService = commonService;

  @override
  Future<ResponseModel<PageData<Content>>> getKnowledge(
      {int page = PaginationConst.page,
      int limit = PaginationConst.limit}) async {
    return await _commonService.fetchContents(
        categoryId: Content.knowledge, page: page, limit: limit);
  }

  @override
  Future<ResponseModel<Content>> getKnowledgeDetail(String hashTag) async {
    return await _commonService.getContent(hashTag);
  }
}
