import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'supplier_service.g.dart';

@RestApi()
abstract class SupplierService {
  factory SupplierService(Dio dio) = _SupplierService;

  @GET('supplier')
  Future<ResponseModel<PageData<Supplier>>> getSuppliers(
      {@Query('page') int page = 1,
      @Query('limit') int limit = 10,
      @Query('sort') String sort});

  @GET('supplier/{supplierId}')
  Future<ResponseModel<Supplier>> getSupplierDetail({
    @Path() int supplierId,
  });
}
