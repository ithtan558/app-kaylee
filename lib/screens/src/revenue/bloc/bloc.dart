import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';

class TotalRevenueBloc extends Cubit<SingleModel<Revenue>>
    with _ReportBlocHelper {
  TotalRevenueBloc({ReportService reportService}) : super(SingleModel()) {
    this._reportService = reportService;
  }

  @override
  void loadData({Brand brand, DateTime startDate, DateTime endDate}) {
    super.loadData(brand: brand, startDate: startDate, endDate: endDate);
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: _reportService.getTotal(
          startDate: startDateInString,
          endDate: endDateInString,
          brandId: _brand?.id),
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

class EmployeeRevenueBloc extends Cubit<SingleModel<List<EmployeeRevenue>>>
    with _ReportBlocHelper {
  EmployeeRevenueBloc({ReportService reportService}) : super(SingleModel()) {
    this._reportService = reportService;
  }

  @override
  void loadData({Brand brand, DateTime startDate, DateTime endDate}) {
    super.loadData(brand: brand, startDate: startDate, endDate: endDate);
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: _reportService.getTotalByEmployee(
          startDate: startDateInString,
          endDate: endDateInString,
          brandId: brand?.id),
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

class ServiceRevenueBloc extends Cubit<SingleModel<List<ServiceRevenue>>>
    with _ReportBlocHelper {
  ServiceRevenueBloc({ReportService reportService}) : super(SingleModel()) {
    this._reportService = reportService;
  }

  @override
  void loadData({Brand brand, DateTime startDate, DateTime endDate}) {
    super.loadData(brand: brand, startDate: startDate, endDate: endDate);
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: _reportService.getTotalByService(
          startDate: startDateInString,
          endDate: endDateInString,
          brandId: brand?.id),
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

mixin _ReportBlocHelper {
  ReportService _reportService;
  Brand _brand;
  DateTime _startDate;
  DateTime _endDate;

  String get startDateInString =>
      _startDate?.toFormatString(pattern: dateFormat);

  String get endDateInString => _endDate?.toFormatString(pattern: dateFormat);

  @mustCallSuper
  void loadData({Brand brand, DateTime startDate, DateTime endDate}) {
    if (brand.isNotNull) this._brand = brand;
    if (startDate.isNotNull) this._startDate = startDate;
    if (endDate.isNotNull) this._endDate = endDate;
  }
}
