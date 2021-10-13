import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';

class CustomerDetailScreenBloc extends Cubit<SingleModel<Customer>>
    implements CRUDInterface {
  final CustomerApi customerService;

  CustomerDetailScreenBloc({required this.customerService, Customer? customer})
      : super(SingleModel(item: customer));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: customerService.newCustomer(
        name: state.item?.name,
        birthday: state.item?.birthday?.toFormatString(pattern: dateFormat),
        hometownCityId: state.item?.hometownCity?.id,
        address: state.item?.address,
        cityId: state.item?.city?.id,
        districtId: state.item?.district?.id,
        wardsId: state.item?.wards?.id,
        phone: state.item?.phone,
        image: state.item?.imageFile,
        email: state.item?.email,
      ),
      onSuccess: ({message, result}) {
        emit(NewCustomerDetailModel.copy(state
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
  void delete() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: customerService.deleteCustomer(customerId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(DeleteCustomerDetailModel.copy(state
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
  void get() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: customerService.getCustomer(customerId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(CustomerDetailModel.copy(state
          ..loading = false
          ..item = result));
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
      request: customerService.updateCustomer(
        name: state.item?.name,
        birthday: state.item?.birthday?.toFormatString(pattern: dateFormat),
        hometownCityId: state.item?.hometownCity?.id,
        address: state.item?.address,
        cityId: state.item?.city?.id,
        districtId: state.item?.district?.id,
        wardsId: state.item?.wards?.id,
        phone: state.item?.phone,
        image: state.item?.imageFile,
        email: state.item?.email,
        customerId: state.item?.id,
        id: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateCustomerDetailModel.copy(state
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
}

class CustomerDetailModel extends SingleModel<Customer> {
  CustomerDetailModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item;
  }
}

class DeleteCustomerDetailModel extends SingleModel<Customer> {
  DeleteCustomerDetailModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..message = old.message;
  }
}

class UpdateCustomerDetailModel extends SingleModel<Customer> {
  UpdateCustomerDetailModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..message = old.message;
  }
}

class NewCustomerDetailModel extends SingleModel<Customer> {
  NewCustomerDetailModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..message = old.message;
  }
}
