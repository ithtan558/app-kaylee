import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/revenue/widget/report_bloc_helper.dart';
import 'package:kaylee/services/services.dart';

class ProductRevenueSectionBloc extends Cubit<SingleModel<List<ServiceRevenue>>>
    with ReportBlocHelper {
  ProductRevenueSectionBloc({ReportService reportService})
      : super(SingleModel()) {
    this.reportService = reportService;
  }

  @override
  void loadData({Brand brand, DateTime startDate, DateTime endDate}) {
    super.loadData(brand: brand, startDate: startDate, endDate: endDate);
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: reportService.getTotalByProduct(
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
