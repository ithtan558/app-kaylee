import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CustomerServiceImpl implements CustomerService {
  final CustomerApi _api;

  CustomerServiceImpl(this._api);

  @override
  Future<ResponseModel> deleteCustomer({int? customerId}) {
    return _api.deleteCustomer(customerId: customerId);
  }

  @override
  Future<ResponseModel<List<Customer>>> findCustomer({String? keyword}) {
    return _api.findCustomer(keyword: keyword);
  }

  @override
  Future<ResponseModel<Customer>> getCustomer({int? customerId}) {
    return _api.getCustomer(customerId: customerId);
  }

  @override
  Future<ResponseModel<List<CustomerType>>> getCustomerType() {
    return _api.getCustomerType();
  }

  @override
  Future<ResponseModel<PageData<Customer>>> getCustomers(
      {int? page,
      int? limit,
      String? keyword,
      String? sort,
      int? typeId,
      int? cityId,
      String? districtIds}) {
    return _api.getCustomers(
      page: page,
      limit: limit,
      keyword: keyword,
      sort: sort,
      typeId: typeId,
      cityId: cityId,
      districtIds: districtIds,
    );
  }

  @override
  Future<ResponseModel<Customer>> newCustomer(
      {String? name,
      String? birthday,
      int? hometownCityId,
      String? address,
      int? cityId,
      int? districtId,
      int? wardsId,
      String? phone,
      File? image,
      String? email}) {
    return _api.newCustomer(
      name: name,
      birthday: birthday,
      hometownCityId: hometownCityId,
      address: address,
      cityId: cityId,
      districtId: districtId,
      wardsId: wardsId,
      phone: phone,
      image: image,
      email: email,
    );
  }

  @override
  Future<ResponseModel<Customer>> updateCustomer(
      {String? name,
      String? birthday,
      int? hometownCityId,
      String? address,
      int? cityId,
      int? districtId,
      int? wardsId,
      String? phone,
      File? image,
      String? email,
      int? id,
      int? customerId}) {
    return _api.updateCustomer(
      name: name,
      birthday: birthday,
      hometownCityId: hometownCityId,
      address: address,
      cityId: cityId,
      districtId: districtId,
      wardsId: wardsId,
      phone: phone,
      image: image,
      email: email,
      id: id,
      customerId: customerId,
    );
  }
}
