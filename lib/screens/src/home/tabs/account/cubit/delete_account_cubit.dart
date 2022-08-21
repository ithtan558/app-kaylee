import 'package:anth_package/anth_package.dart';
import 'package:bloc/bloc.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/models/src/request/update_status/update_status.dart';

class DeleteAccountCubit extends Cubit<SingleModel> implements CRUDInterface {
  DeleteAccountCubit({required UserApi userApi, required UserInfo userInfo})
      : _userApi = userApi,
        _userInfo = userInfo,
        super(SingleModel());
  final UserApi _userApi;
  final UserInfo _userInfo;

  @override
  void create() {}

  @override
  void delete() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: _userApi.updateStatus(
          status: UpdateStatus(userId: _userInfo.id!, status: 0)),
      onSuccess: ({message, result}) {
        emit(DeleteAccountState.copy(state
          ..loading = false
          ..message = message));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void get() {}

  @override
  void update() {}
}

class DeleteAccountState extends SingleModel {
  DeleteAccountState.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..message = old.message
      ..item = old.item;
  }
}
