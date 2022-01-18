import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class KnowledgeRepository {
  Future<ResponseModel<PageData<Content>>> getKnowledge({
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  });

  Future<ResponseModel<Content>> getKnowledgeDetail(String hashTag);
}
