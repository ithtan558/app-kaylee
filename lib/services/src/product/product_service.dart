import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'product_service.g.dart';

@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio) = _ProductService;

  @GET('product')
  Future<ResponseModel<Products>> getProducts(
      {@Query('supplier_id') int supplierId,
      @Query('sort') String sort,
      @Query('category_id') int categoryId,
      @Query('page') int page = 1,
      @Query('limit') int limit = 10});
}
