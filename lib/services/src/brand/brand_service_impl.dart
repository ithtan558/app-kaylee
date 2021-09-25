import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/src/response/brand/brand.dart';
import 'package:kaylee/models/src/response/page_data/page_data.dart';
import 'package:kaylee/services/services.dart';

class BrandServiceImpl implements BrandService {
  final BrandApi _api;

  BrandServiceImpl(this._api);

  @override
  Future<ResponseModel> deleteBrand({int? brandId}) {
    return _api.deleteBrand(brandId: brandId);
  }

  @override
  Future<ResponseModel<List<Brand>>> getAllBrands() {
    return _api.getAllBrands();
  }

  @override
  Future<ResponseModel<Brand>> getBrand({int? brandId}) {
    return _api.getBrand(brandId: brandId);
  }

  @override
  Future<ResponseModel<PageData<Brand>>> getBrands(
      {String? keyword, int? page, int? limit, cityId, String? districtIds}) {
    return _api.getBrands(
      keyword: keyword,
      page: page,
      limit: limit,
      cityId: cityId,
      districtIds: districtIds,
    );
  }

  @override
  Future<ResponseModel> newBrand(
      {String? name,
      String? phone,
      String? location,
      int? cityId,
      int? districtId,
      String? startTime,
      String? endTime,
      int? wardsId,
      File? image}) {
    return _api.newBrand(
      name: name,
      phone: phone,
      location: location,
      cityId: cityId,
      districtId: districtId,
      startTime: startTime,
      endTime: endTime,
      wardsId: wardsId,
      image: image,
    );
  }

  @override
  Future<ResponseModel> updateBrand(
      {String? name,
      String? phone,
      String? location,
      int? cityId,
      int? districtId,
      String? startTime,
      String? endTime,
      int? wardsId,
      File? image,
      int? id,
      int? brandId}) {
    return _api.updateBrand(
      name: name,
      phone: phone,
      location: location,
      cityId: cityId,
      districtId: districtId,
      startTime: startTime,
      endTime: endTime,
      wardsId: wardsId,
      image: image,
      id: id,
      brandId: brandId,
    );
  }
}
