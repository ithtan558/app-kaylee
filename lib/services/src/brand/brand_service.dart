import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'brand_service.g.dart';

@RestApi()
abstract class BrandService {
  factory BrandService(Dio dio) = _BrandService;

  @GET('brand')
  Future<ResponseModel<Brands>> getBranches({
    @Query('keyword') String keyword,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('city_id') int cityId,
    @Query('district_ids') String districtIds,
  });

  @GET('brand/{branchId}')
  Future<ResponseModel<Brand>> getBranch({@Path() branchId});

  @POST('brand')
  Future<ResponseModel> newBranch({
    @Part() String name,
    @Part() String phone,
    @Part() String location,
    @Part(name: 'city_id') String cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'start_time') int startTime,
    @Part(name: 'end_time') int endTime,
    @Part(name: 'wards_id') int wardsId,
    @Part() File image,
  });

  @POST('brand/{brandId}')
  Future<ResponseModel> updateBranch({
    @Part() String name,
    @Part() String phone,
    @Part() String location,
    @Part(name: 'city_id') String cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'start_time') int startTime,
    @Part(name: 'end_time') int endTime,
    @Part(name: 'wards_id') int wardsId,
    @Part() File image,
    @Path() int brandId,
  });

  @DELETE('brand/delete/{brandId}')
  Future<ResponseModel> deleteBranch({@Path() int brandId});
}
