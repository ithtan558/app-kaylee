import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'brand_api.g.dart';

const String _brandPath = 'brand';

@RestApi()
abstract class BrandApi {
  factory BrandApi(Dio dio) = _BrandApi;

  @GET(_brandPath + '/all')
  Future<ResponseModel<List<Brand>>> getAllBrands();

  @GET(_brandPath)
  Future<ResponseModel<PageData<Brand>>> getBrands({
    @Query('keyword') String? keyword,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('city_id') int? cityId,
    @Query('district_ids') String? districtIds,
  });

  @GET(_brandPath + '/{brandId}')
  Future<ResponseModel<Brand>> getBrand({@Path() int? brandId});

  @POST(_brandPath)
  @MultiPart()
  Future<ResponseModel> newBrand({
    @Part() String? name,
    @Part() String? phone,
    @Part() String? location,
    @Part(name: 'city_id') int? cityId,
    @Part(name: 'district_id') int? districtId,
    @Part(name: 'start_time') String? startTime,
    @Part(name: 'end_time') String? endTime,
    @Part(name: 'wards_id') int? wardsId,
    @Part() File? image,
  });

  @POST(_brandPath + '/{brandId}')
  @MultiPart()
  Future<ResponseModel> updateBrand({
    @Part() String? name,
    @Part() String? phone,
    @Part() String? location,
    @Part(name: 'city_id') int? cityId,
    @Part(name: 'district_id') int? districtId,
    @Part(name: 'start_time') String? startTime,
    @Part(name: 'end_time') String? endTime,
    @Part(name: 'wards_id') int? wardsId,
    @Part() File? image,
    @Part() int? id,
    @Path() int? brandId,
  });

  @DELETE(_brandPath + '/delete/{brandId}')
  Future<ResponseModel> deleteBrand({@Path() int? brandId});
}
