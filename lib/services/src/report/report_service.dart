import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'report_service.g.dart';

@RestApi()
abstract class ReportService {
  factory ReportService(Dio dio) = _ReportService;

  @GET('report/get-total')
  Future<ResponseModel<Revenue>> getTotal({
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('brand_id') int brandId,
  });

  @GET('report/get-total-by-employee-date')
  Future<ResponseModel<List<EmployeeRevenue>>> getTotalByEmployee({
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('brand_id') int brandId,
  });

  @GET('report/get-total-by-service-date')
  Future<ResponseModel<List<ServiceRevenue>>> getTotalByService({
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('brand_id') int brandId,
  });

  @GET('report/get-total-by-product-date')
  Future<ResponseModel<List<ServiceRevenue>>> getTotalByProduct({
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('brand_id') int brandId,
  });
}
