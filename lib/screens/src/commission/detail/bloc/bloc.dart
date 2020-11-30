import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';

class CommissionDetailScreenBloc extends Cubit<SingleModel> {
  final CommissionService commissionService;
  Employee employee;
  DateTime startDate;
  DateTime endDate;

  CommissionDetailScreenBloc({
    this.commissionService,
    this.startDate,
    this.endDate,
    this.employee,
  }) : super(SingleModel()) {
    endDate = startDate;
  }

  void loadWithDate({DateTime startDate, DateTime endDate}) {
    this.startDate = startDate;
    this.endDate = endDate;
    loadDetail();
  }

  void loadDetail() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commissionService.getDetail(
        userId: employee.id,
        startDate: startDate.toFormatString(pattern: dateFormat),
        endDate: endDate.toFormatString(pattern: dateFormat),
      ),
      onSuccess: ({message, result}) {
        emit(CommissionDetailModel.copy(
          this.state
            ..loading = false
            ..item = result,
        ));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }
}

class CommissionDetailModel extends SingleModel<Commission> {
  CommissionDetailModel.copy(SingleModel old) {
    this
      ..item = old?.item
      ..loading = old.loading;
  }
}
