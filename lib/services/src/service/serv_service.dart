import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'serv_service.g.dart';

@RestApi()
abstract class ServService {
  factory ServService(Dio dio) = _ServService;

  @GET('service-category/all')
  Future<ResponseModel<ServiceCate>> getCategories();

  @GET('service-category')
  Future<ResponseModel<ServCategories>> getCategoryList({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('sort') String sort,
  });

  @GET('service-category/{serviceId}')
  Future<ResponseModel<ServiceCate>> getServiceCateDetail(
      {@Path() int serviceId});

  @POST('service-category')
  @MultiPart()
  Future<ResponseModel> newServiceCate({
    @Part() String name,
    @Part() String code,
    @Part() int sequence,
  });

  @POST('service-category/{serviceId}')
  @MultiPart()
  Future<ResponseModel> updateProdCate(
      {@Part() String name,
      @Part() String code,
      @Part() int sequence,
      @Part() int id,
      @Path() int serviceId});

  @DELETE('service-category/delete/{serviceId}')
  Future<ResponseModel> deleteProdCate({@Path() int serviceId});

  @GET('service')
  Future<ResponseModel<Services>> getServices({
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
      @Part() int id,
      @Path() int serviceId});

  @GET('service/{serviceId}')
  Future<ResponseModel<Service>> getService({@Path() int serviceId});

  @DELETE('service/delete/{serviceId}}')
  Future<ResponseModel<Service>> deleteService({@Path() int serviceId});
}
