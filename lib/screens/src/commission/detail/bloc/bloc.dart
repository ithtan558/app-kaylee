import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';

class CommissionDetailScreenBloc extends Cubit<SingleModel> {
  final CommissionService commissionService;
  Employee employee;
  DateTime date;

  CommissionDetailScreenBloc({
    this.commissionService,
    this.date,
    this.employee,
  }) : super(SingleModel());

  void loadWithDate({DateTime date}) {
    this.date = date;
    loadDetail();
  }

  void loadDetail() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commissionService.getDetail(
        userId: employee.id,
        startDate: date.toFormatString(pattern: dateFormat),
        endDate: date.toFormatString(pattern: dateFormat),
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
