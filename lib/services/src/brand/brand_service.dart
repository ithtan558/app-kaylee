import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'brand_service.g.dart';

@RestApi()
abstract class BrandService {
  factory BrandService(Dio dio) = _BrandService;

  @GET('brand')
  Future<ResponseModel<Brands>> getBrands({
    @Query('keyword') String keyword,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('city_id') int cityId,
    @Query('district_ids') String districtIds,
  });

  @GET('brand/{brandId}')
  Future<ResponseModel<Brand>> getBrand({@Path() int brandId});

  @POST('brand')
  Future<ResponseModel> newBrand({
    @Part() String name,
    @Part() String phone,
    @Part() String location,
    @Part(name: 'city_id') int cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'start_time') String startTime,
    @Part(name: 'end_time') String endTime,
    @Part(name: 'wards_id') int wardsId,
    @Part() File image,
  });

  @POST('brand/{brandId}')
  Future<ResponseModel> updateBrand({
    @Part() String name,
    @Part() String phone,
    @Part() String location,
    @Part(name: 'city_id') int cityId,
    @Part(name: 'district_id') int districtId,
    @Part(name: 'start_time') String startTime,
    @Part(name: 'end_time') String endTime,
    @Part(name: 'wards_id') int wardsId,
    @Part() File image,
    @Path() int brandId,
  });

  @DELETE('brand/delete/{brandId}')
  Future<ResponseModel> deleteBrand({@Path() int brandId});
}
