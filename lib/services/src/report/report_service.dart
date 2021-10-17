import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class ReportService {
  Future<ResponseModel<Revenue>> getTotal({
    String? startDate,
    String? endDate,
    int? brandId,
  });

  Future<ResponseModel<List<EmployeeRevenue>>> getTotalByEmployee({
    String? startDate,
    String? endDate,
    int? brandId,
  });

  Future<ResponseModel<List<ServiceRevenue>>> getTotalByService({
    String? startDate,
    String? endDate,
    int? brandId,
  });

  Future<ResponseModel<List<ServiceRevenue>>> getTotalByProduct({
    String? startDate,
    String? endDate,
    int? brandId,
  });
}
