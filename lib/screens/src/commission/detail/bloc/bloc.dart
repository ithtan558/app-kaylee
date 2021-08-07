import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/utils/utils.dart';

class CommissionDetailScreenBloc extends Cubit<SingleModel> {
  final CommissionApi commissionService;
  Employee employee;
  DateTime startDate;
  late DateTime endDate;

  CommissionDetailScreenBloc({
    required this.commissionService,
    required this.startDate,
    required this.employee,
  }) : super(SingleModel()) {
    endDate = startDate;
  }

  void loadWithDate({required DateTime startDate, required DateTime endDate}) {
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
          state
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
      ..item = old.item
      ..loading = old.loading;
  }
}
