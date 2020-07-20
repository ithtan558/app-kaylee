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
      @Query('keyword') String keyword,
      @Query('sort') String sort,
      @Query('category_id') int categoryId,
      @Query('page') int page,
      @Query('limit') int limit});

  @GET('product-category/all')
  Future<ResponseModel<Category>> getProdCategory(
      {@Query('supplier_id') int supplier_id});

  @GET('product/{proId}')
  Future<ResponseModel<Product>> getProduct({@Path() int proId});
}
