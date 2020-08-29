import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CommissionSettingBloc extends Cubit<SingleModel<CommissionSetting>> {
  final CommissionService commissionService;
  final Employee employee;

  CommissionSettingBloc({
    this.commissionService,
    this.employee,
  }) : super(SingleModel());

  void loadSetting() {
    RequestHandler(
      request: commissionService.getSetting(
        userId: employee.id,
      ),
      onSuccess: ({message, result}) {
        emit(CommissionSettingModel.copy(state..item = result));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..code = code
          ..error = error));
      },
    );
  }

  void updateSetting({
    int product,
    int service,
  }) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commissionService.getUpdateSetting(
        userId: employee.id,
        product: product,
        service: service,
      ),
      onSuccess: ({message, result}) {
        emit(CommissionSettingUpdateModel.copy(state
          ..loading = false
          ..message = message));
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

class CommissionSettingUpdateModel extends SingleModel<CommissionSetting> {
  CommissionSettingUpdateModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class CommissionSettingModel extends SingleModel<CommissionSetting> {
  CommissionSettingModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}
