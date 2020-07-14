import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'supplier_service.g.dart';

@RestApi()
abstract class SupplierService {
  factory SupplierService(Dio dio) = _SupplierService;

  @GET('supplier')
  Future<ResponseModel<Supplier>> getSuppliers(
      {int page = 1, int limit = 10, String sort = ''});
}
