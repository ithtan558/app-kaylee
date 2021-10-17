import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class CustomerService {
  Future<ResponseModel<PageData<Customer>>> getCustomers({
    int? page,
    int? limit,
    String? keyword,
    String? sort,
    int? typeId,
    int? cityId,
    String? districtIds,
  });

  Future<ResponseModel<List<Customer>>> findCustomer({
    String? keyword,
  });

  Future<ResponseModel<Customer>> getCustomer({int? customerId});

  Future<ResponseModel<Customer>> newCustomer({
    String? name,
    String? birthday,
    int? hometownCityId,
    String? address,
    int? cityId,
    int? districtId,
    int? wardsId,
    String? phone,
    File? image,
    String? email,
  });

  Future<ResponseModel<Customer>> updateCustomer({
    String? name,
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
    int? customerId,
  });

  Future<ResponseModel> deleteCustomer({int? customerId});

  Future<ResponseModel<List<CustomerType>>> getCustomerType();
}
