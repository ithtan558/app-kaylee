import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/src/response/report/employee/employee_revenue.dart';
import 'package:kaylee/models/src/response/report/revenue/revenue.dart';
import 'package:kaylee/models/src/response/report/service/service_revenue.dart';
import 'package:kaylee/services/services.dart';

class ReportServiceImpl implements ReportService {
  final ReportApi _api;

  ReportServiceImpl(this._api);

  @override
  Future<ResponseModel<Revenue>> getTotal(
      {String? startDate, String? endDate, int? brandId}) {
    return _api.getTotal(
      startDate: startDate,
      endDate: endDate,
      brandId: brandId,
    );
  }

  @override
  Future<ResponseModel<List<EmployeeRevenue>>> getTotalByEmployee(
      {String? startDate, String? endDate, int? brandId}) {
    return _api.getTotalByEmployee(
      startDate: startDate,
      endDate: endDate,
      brandId: brandId,
    );
  }

  @override
  Future<ResponseModel<List<ServiceRevenue>>> getTotalByProduct(
      {String? startDate, String? endDate, int? brandId}) {
    return _api.getTotalByProduct(
      startDate: startDate,
      endDate: endDate,
      brandId: brandId,
    );
  }

  @override
  Future<ResponseModel<List<ServiceRevenue>>> getTotalByService(
      {String? startDate, String? endDate, int? brandId}) {
    return _api.getTotalByService(
      startDate: startDate,
      endDate: endDate,
      brandId: brandId,
    );
  }
}
