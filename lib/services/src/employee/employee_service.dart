import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'employee_service.g.dart';

@RestApi()
abstract class EmployeeService {
  factory EmployeeService(Dio dio) = _EmployeeService;

  @GET('employee')
  Future<ResponseModel<Employees>> getServices({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('keyword') String keyword,
    @Query('sort') String sort,
  });

  @GET('employee/{employeeId}')
  Future<ResponseModel<Employees>> getService({@Path() int employeeId});

  @POST('employee')
  @MultiPart()
  Future<ResponseModel> newService({
    @Part(name: 'first_name') String firstName,
    @Part(name: 'last_name') String lastName,
    @Part() int birthday,
    @Part(name: 'hometown_city_id') int hometownCityId,
    @Part() int address,
    @Part(name: 'city_id') int cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'wards_id') int wardsId,
    @Part(name: 'role_id') int roleId,
    @Part(name: 'brand_id') int brandId,
    @Part() String phone,
    @Part() File image,
    @Part() String email,
  });

  @POST('employee/{employeeId}')
  @MultiPart()
  Future<ResponseModel> updateService({
    @Part(name: 'first_name') String firstName,
    @Part(name: 'last_name') String lastName,
    @Part() int birthday,
    @Part(name: 'hometown_city_id') int hometownCityId,
    @Part() int address,
    @Part(name: 'city_id') int cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'wards_id') int wardsId,
    @Part(name: 'role_id') int roleId,
    @Part(name: 'brand_id') int brandId,
    @Part() String phone,
    @Part() File image,
    @Part() String email,
    @Part() int id,
    @Path() int employeeId,
  });

  @DELETE('employee/delete/{employeeId}')
  Future<ResponseModel> deleteService({@Path() int employeeId});
}
