import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'product_service.g.dart';

@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio) = _ProductService;

  @GET('product')
  Future<ResponseModel<Products>> getProducts({@Query('supplier_id') int supplierId,
    @Query('keyword') String keyword,
    @Query('sort') String sort,
      @Query('category_id') int categoryId,
      @Query('page') int page,
      @Query('limit') int limit});

  @GET('product-category/all')
  Future<ResponseModel<Category>> getProdCategory(
      {@Query('supplier_id') int supplier_id});

  @GET('product/{proId}')
  Future<ResponseModel<Product>> getProduct({@Path() int proId});

  @POST('product')
  @MultiPart()
  Future<ResponseModel> newProduct({
    @Part() String name,
    @Part() String description,
    @Part(name: 'brand_ids') String brandIds,
    @Part() int price,
    @Part() File image,
    @Part(name: 'category_id') int categoryId,
  });

  @POST('product/{prodId}')
  @MultiPart()
  Future<ResponseModel> updateProduct({
    @Part() String name,
    @Part() String description,
    @Part(name: 'brand_ids') String brandIds,
    @Part() int price,
    @Part() File image,
    @Part(name: 'category_id') int categoryId,
    @Part() int id,
    @Path() int prodId,
  });

  @DELETE('product/delete/{prodId}')
  Future<ResponseModel> deleteProduct({
    @Path() int prodId,
  });
}
