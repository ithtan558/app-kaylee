import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'customer_service.g.dart';

@RestApi()
abstract class CustomerService {
  factory CustomerService(Dio dio) = _CustomerService;

  @GET('customer')
  Future<ResponseModel<PageData<Customer>>> getCustomers({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('keyword') String keyword,
    @Query('sort') String sort,
    @Query('type_id') int typeId,
    @Query('city_id') int cityId,
    @Query('district_ids') String districtIds,
  });

  @GET('customer/get-by-phone-and-name')
  Future<ResponseModel<List<Customer>>> findCustomer({
    @Query('keyword') String keyword,
  });

  @GET('customer/{customerId}')
  Future<ResponseModel<Customer>> getCustomer({@Path() int customerId});

  @POST('customer')
  @MultiPart()
  Future<ResponseModel<Customer>> newCustomer({
    @Part(name: 'first_name') String firstName,
    @Part(name: 'last_name') String lastName,
    @Part() String birthday,
    @Part(name: 'hometown_city_id') int hometownCityId,
    @Part() String address,
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
    @Part() String birthday,
    @Part(name: 'hometown_city_id') int hometownCityId,
    @Part() String address,
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
  Future<ResponseModel<List<CustomerType>>> getCustomerType();
}
