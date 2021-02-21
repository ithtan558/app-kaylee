import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'serv_service.g.dart';

@RestApi()
abstract class ServService {
  factory ServService(Dio dio) = _ServService;

  @GET('service-category/all')
  Future<ResponseModel<List<ServiceCate>>> getCategories();

  @GET('service-category')
  Future<ResponseModel<PageData<ServiceCate>>> getCategoryList({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('sort') String sort,
  });

  @GET('service-category/{cateId}')
  Future<ResponseModel<ServiceCate>> getServiceCateDetail({@Path() int cateId});

  @POST('service-category')
  @MultiPart()
  Future<ResponseModel> newServiceCate({
    @Part() String name,
    @Part() String code,
    @Part() int sequence,
  });

  @POST('service-category/{cateId}')
  @MultiPart()
  Future<ResponseModel> updateServiceCate(
      {@Part() String name,
      @Part() String code,
      @Part() int sequence,
      @Part() int id,
      @Path() int cateId});

  @DELETE('service-category/delete/{cateId}')
  Future<ResponseModel> deleteServiceCate({@Path() int cateId});

  @GET('service')
  Future<ResponseModel<PageData<Service>>> getServices({
    @Query('keyword') String keyword,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('sort') String sort,
    @Query('category_id') int categoryId,
    @Query('brand_ids') String brandIds,
    @Query('start_price') int startPrice,
    @Query('end_price') int endPrice,
  });

  @POST('service')
  @MultiPart()
  Future<ResponseModel> newService({
    @Part() String name,
    @Part() String description,
    @Part(name: 'brand_ids') String brandIds,
    @Part() int time,
    @Part() int price,
    @Part() File image,
    @Part(name: 'category_id') int categoryId,
    @Part(name: 'code') String code,
  });

  @POST('service/{serviceId}')
  @MultiPart()
  Future<ResponseModel> updateService(
      {@Part() String name,
      @Part() String description,
      @Part(name: 'brand_ids') String brandIds,
      @Part() int time,
      @Part() int price,
      @Part() File image,
      @Part(name: 'category_id') int categoryId,
      @Part(name: 'code') String code,
      @Part() int id,
      @Path() int serviceId});

  @GET('service/{serviceId}')
  Future<ResponseModel<Service>> getService({@Path() int serviceId});

  @DELETE('service/delete/{serviceId}}')
  Future<ResponseModel<Service>> deleteService({@Path() int serviceId});
}
