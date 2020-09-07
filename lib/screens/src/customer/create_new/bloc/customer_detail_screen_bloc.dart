import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CustomerDetailScreenBloc extends Cubit<SingleModel<Customer>>
    implements CRUDInterface {
  final CustomerService customerService;

  CustomerDetailScreenBloc({this.customerService, Customer customer})
      : super(SingleModel(item: customer));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: customerService.newCustomer(
        firstName: state.item?.firstName,
        lastName: state.item?.lastName,
        birthday: state.item?.birthday,
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
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
          ..error = null
          ..code = null));
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
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
          ..error = null
          ..code = null));
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
        firstName: state.item?.firstName,
        lastName: state.item?.lastName,
        birthday: state.item?.birthday,
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
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
          ..error = null
          ..code = null));
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
      ..loading = old?.loading
      ..item = old?.item;
  }
}
