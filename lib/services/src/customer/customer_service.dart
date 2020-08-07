import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'customer_service.g.dart';

@RestApi()
abstract class CustomerService {
  factory CustomerService(Dio dio) = _CustomerService;

  @GET('customer')
  Future<ResponseModel<Customers>> getCustomers({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('keyword') String keyword,
    @Query('sort') String sort,
    @Query('type_id') int typeId,
    @Query('city_id') int cityId,
    @Query('district_ids') String districtIds,
  });

  @GET('customer/{customerId}')
  Future<ResponseModel<Customer>> getCustomer({@Path() int customerId});

  @POST('customer')
  @MultiPart()
  Future<ResponseModel<Customer>> newCustomer({
    @Part(name: 'first_name') String firstName,
    @Part(name: 'last_name') String lastName,
    @Part() int birthday,
    @Part(name: 'hometown_city_id') int hometownCityId,
    @Part() int address,
    @Part(name: 'city_id') int cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'wards_id') int wardsId,
    @Part() String phone,
    @Part() File image,
    @Part() String email,
  });

  @POST('customer/{customerId}')
  @MultiPart()
  Future<ResponseModel<Customer>> updateCustomer({
    @Part(name: 'first_name') String firstName,
    @Part(name: 'last_name') String lastName,
    @Part() int birthday,
    @Part(name: 'hometown_city_id') int hometownCityId,
    @Part() int address,
    @Part(name: 'city_id') int cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'wards_id') int wardsId,
    @Part() String phone,
    @Part() File image,
    @Part() String email,
    @Part() int id,
    @Path() int customerId,
  });

  @DELETE('customer/delete/{customerId}')
  Future<ResponseModel> deleteCustomer({@Path() int customerId});

  @GET('customer-type/all')
  Future<ResponseModel<CustomerType>> getCustomerType();
}
