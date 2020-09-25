import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';

class TotalRevenueBloc extends Cubit<SingleModel<Revenue>> {
  final ReportService reportService;

  TotalRevenueBloc({this.reportService}) : super(SingleModel());
  Brand brand;
  DateTime date;

  void loadData() {
    final dateInString = date?.toFormatString(pattern: dateFormat);
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: reportService.getTotal(
          startDate: dateInString, endDate: dateInString, brandId: brand?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }
}

class EmployeeRevenueBloc extends Cubit<SingleModel<EmployeeRevenue>> {
  final ReportService reportService;

  EmployeeRevenueBloc({this.reportService}) : super(SingleModel());
  Brand brand;
  DateTime date;

  void loadData() {
    final dateInString = date?.toFormatString(pattern: dateFormat);
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: reportService.getTotalByEmployee(
          startDate: dateInString, endDate: dateInString, brandId: brand?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }
}

class ServiceRevenueBloc extends Cubit<SingleModel<ServiceRevenue>> {
  final ReportService reportService;

  ServiceRevenueBloc({this.reportService}) : super(SingleModel());
  Brand brand;
  DateTime date;

  void loadData() {
    final dateInString = date?.toFormatString(pattern: dateFormat);
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: reportService.getTotalByService(
          startDate: dateInString, endDate: dateInString, brandId: brand?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }
}
