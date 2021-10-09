import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class BrandService {

  Future<ResponseModel<List<Brand>>> getAllBrands();

  Future<ResponseModel<PageData<Brand>>> getBrands({
    String? keyword,
    int? page,
    int? limit,
    cityId,
    String? districtIds,
  });

  Future<ResponseModel<Brand>> getBrand({int? brandId});

  Future<ResponseModel> newBrand({
    String? name,
    String? phone,
    String? location,
    int? cityId,
    int? districtId,
    String? startTime,
    String? endTime,
    int? wardsId,
    File? image,
  });

  Future<ResponseModel> updateBrand({
    String? name,
    String? phone,
    String? location,
    int? cityId,
    int? districtId,
    String? startTime,
    String? endTime,
    int? wardsId,
    File? image,
    int? id,
    int? brandId,
  });

  Future<ResponseModel> deleteBrand({int? brandId});
}
