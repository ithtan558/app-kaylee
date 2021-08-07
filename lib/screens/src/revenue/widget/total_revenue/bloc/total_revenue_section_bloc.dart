import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/revenue/widget/report_bloc_helper.dart';

class TotalRevenueSectionBloc extends Cubit<SingleModel<Revenue>>
    with ReportBlocHelper {
  TotalRevenueSectionBloc({required ReportApi reportService})
      : super(SingleModel()) {
    this.reportService = reportService;
  }

  @override
  void loadData({Brand? brand, DateTime? startDate, DateTime? endDate}) {
    super.loadData(brand: brand, startDate: startDate, endDate: endDate);
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: reportService.getTotal(
          startDate: startDateInString,
          endDate: endDateInString,
          brandId: this.brand?.id),
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
