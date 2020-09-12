import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class StaffDetailScreenBloc extends Cubit<SingleModel<Employee>>
    implements CRUDInterface {
  final EmployeeService employeeService;

  StaffDetailScreenBloc({this.employeeService, Employee employee})
      : super(SingleModel(item: employee));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: employeeService.newEmployee(
        firstName: state.item?.firstName,
        lastName: state.item?.lastName,
        birthday: state.item?.birthday,
        hometownCityId: state.item?.hometownCity?.id,
        address: state.item?.address,
        cityId: state.item?.city?.id,
        districtId: state.item?.district?.id,
        wardsId: state.item?.wards?.id,
        roleId: state.item?.role?.id,
        brandId: state.item?.brand?.id,
        phone: state.item?.phone,
        image: state.item?.imageFile,
        email: state.item?.email,
        password: state.item?.password,
      ),
      onSuccess: ({message, result}) {
        emit(NewStaffDetailModel.copy(
          state
            ..loading = false
            ..message = message,
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

  @override
  void delete() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: employeeService.deleteEmployee(employeeId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(DeleteStaffDetailModel.copy(
          state
            ..loading = false
            ..message = message,
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

  @override
  void get() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: employeeService.getEmployee(employeeId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(StaffDetailModel.copy(
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

  @override
  void update() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: employeeService.updateEmployee(
        firstName: state.item?.firstName,
        lastName: state.item?.lastName,
        birthday: state.item?.birthday,
        hometownCityId: state.item?.hometownCity?.id,
        address: state.item?.address,
        cityId: state.item?.city?.id,
        districtId: state.item?.district?.id,
        wardsId: state.item?.wards?.id,
        roleId: state.item?.role?.id,
        brandId: state.item?.brand?.id,
        phone: state.item?.phone,
        image: state.item?.imageFile,
        email: state.item?.email,
        password: state.item?.password,
        employeeId: state.item?.id,
        id: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateStaffDetailModel.copy(
          state
            ..loading = false
            ..message = message,
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

class StaffDetailModel extends SingleModel<Employee> {
  StaffDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item;
  }
}

class DeleteStaffDetailModel extends SingleModel<Employee> {
  DeleteStaffDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class UpdateStaffDetailModel extends SingleModel<Employee> {
  UpdateStaffDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class NewStaffDetailModel extends SingleModel<Employee> {
  NewStaffDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}
