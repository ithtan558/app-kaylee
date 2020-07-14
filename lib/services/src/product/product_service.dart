import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'product_service.g.dart';

@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio) = _ProductService;

  @GET('product')
  Future<ResponseModel<PageData<Product>>> getProducts(int supplier_id,
      {String sort = '', int category_id = 1, int page = 1, int limit = 10});
}
