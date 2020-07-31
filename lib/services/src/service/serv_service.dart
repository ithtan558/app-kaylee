import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'serv_service.g.dart';

@RestApi()
abstract class ServService {
  factory ServService(Dio dio) = _ServService;

  @GET('service-category/all')
  Future<ResponseModel<ServiceCate>> getCategory();

  @GET('service')
  Future<ResponseModel<Services>> getServices(
      {@Query('keyword') String keyword,
      @Query('page') int page,
      @Query('limit') int limit,
      @Query('sort') String sort,
      @Query('category_id') int categoryId});
}
