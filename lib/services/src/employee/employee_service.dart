import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'employee_service.g.dart';

@RestApi()
abstract class EmployeeService {
  factory EmployeeService(Dio dio) = _EmployeeService;

  @GET('employee')
  Future<ResponseModel<Employees>> getEmployees({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('keyword') String keyword,
    @Query('sort') String sort,
    @Query('brand_id') int brandId,
    @Query('city_id') int cityId,
    @Query('district_ids') String districtIds,
  });

  @GET('employee/get-by-phone-and-name')
  Future<ResponseModel<Employee>> findEmployees({
    @Query('keyword') String keyword,
    @Query('brand_id') int brandId,
  });

  @GET('employee/{employeeId}')
  Future<ResponseModel<Employee>> getEmployee({@Path() int employeeId});

  @POST('employee')
  @MultiPart()
  Future<ResponseModel> newEmployee({
    @Part(name: 'first_name') String firstName,
    @Part(name: 'last_name') String lastName,
    @Part() String birthday,
    @Part(name: 'hometown_city_id') int hometownCityId,
    @Part() String address,
    @Part(name: 'city_id') int cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'wards_id') int wardsId,
    @Part(name: 'role_id') int roleId,
    @Part(name: 'brand_id') int brandId,
    @Part() String phone,
    @Part() File image,
    @Part() String email,
    @Part() String password,
  });

  @POST('employee/{employeeId}')
  @MultiPart()
  Future<ResponseModel> updateEmployee({
    @Part(name: 'first_name') String firstName,
    @Part(name: 'last_name') String lastName,
    @Part() String birthday,
    @Part(name: 'hometown_city_id') int hometownCityId,
    @Part() String address,
    @Part(name: 'city_id') int cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'wards_id') int wardsId,
    @Part(name: 'role_id') int roleId,
    @Part(name: 'brand_id') int brandId,
    @Part() String phone,
    @Part() File image,
    @Part() String email,
    @Part() String password,
    @Part() int id,
    @Path() int employeeId,
  });

  @DELETE('employee/delete/{employeeId}')
  Future<ResponseModel> deleteEmployee({@Path() int employeeId});
}
