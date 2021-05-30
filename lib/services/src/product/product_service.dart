import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'product_service.g.dart';

@RestApi()
abstract class ProductService {
  factory ProductService(Dio dio) = _ProductService;

  @GET('product')
  Future<ResponseModel<PageData<Product>>> getProducts({
    @Query('supplier_id') int? supplierId,
    @Query('keyword') String? keyword,
    @Query('sort') String? sort,
    @Query('category_id') int? categoryId,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('brand_ids') String? brandIds,
  });

  @GET('product-category/all')
  Future<ResponseModel<List<ProdCate>>> getCategories(
      {@Query('supplier_id') int? supplierId});

  @GET('product-category')
  Future<ResponseModel<PageData<ProdCate>>> getCategoryList({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('sort') String? sort,
  });

  @GET('product-category/{cateId}')
  Future<ResponseModel<ProdCate>> getProdCateDetail({@Path() int? cateId});

  @POST('product-category')
  @MultiPart()
  Future<ResponseModel> newProdCate({
    @Part() String? name,
    @Part() String? code,
    @Part() int? sequence,
  });

  @POST('product-category/{cateId}')
  @MultiPart()
  Future<ResponseModel> updateProdCate(
      {@Part() String? name,
      @Part() String? code,
      @Part() int? sequence,
      @Part() int? id,
      @Path() int? cateId});

  @DELETE('product-category/delete/{cateId}')
  Future<ResponseModel> deleteProdCate({@Path() int? cateId});

  @GET('product/{proId}')
  Future<ResponseModel<Product>> getProduct({@Path() int? proId});

  @POST('product')
  @MultiPart()
  Future<ResponseModel> newProduct({
    @Part() String? name,
    @Part() String? description,
    @Part(name: 'brand_ids') String? brandIds,
    @Part() int? price,
    @Part() File? image,
    @Part(name: 'category_id') int? categoryId,
    @Part(name: 'code') String? code,
  });

  @POST('product/{prodId}')
  @MultiPart()
  Future<ResponseModel> updateProduct({
    @Part() String? name,
    @Part() String? description,
    @Part(name: 'brand_ids') String? brandIds,
    @Part() int? price,
    @Part() File? image,
    @Part(name: 'category_id') int? categoryId,
    @Part(name: 'code') String? code,
    @Part() int? id,
    @Path() int? prodId,
  });

  @DELETE('product/delete/{prodId}')
  Future<ResponseModel> deleteProduct({
    @Path() int? prodId,
  });
}
