import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CommissionServiceImpl implements CommissionService {
  final CommissionApi _api;

  CommissionServiceImpl(this._api);

  @override
  Future<ResponseModel<Commission>> getDetail(
      {String? startDate, String? endDate, int? userId}) {
    return _api.getDetail(
      startDate: startDate,
      endDate: endDate,
      userId: userId,
    );
  }

  @override
  Future<ResponseModel<PageData<CommissionOrder>>> getProductOfOrder(
      {String? startDate,
      String? endDate,
      int? userId,
      int? page,
      int? limit}) {
    return _api.getProductOfOrder(
      startDate: startDate,
      endDate: endDate,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<ResponseModel<PageData<CommissionOrder>>> getServiceOfOrder(
      {String? startDate,
      String? endDate,
      int? userId,
      int? page,
      int? limit}) {
    return _api.getServiceOfOrder(
      startDate: startDate,
      endDate: endDate,
      userId: userId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<ResponseModel<CommissionSetting>> getSetting({int? userId}) {
    return _api.getSetting(
      userId: userId,
    );
  }

  @override
  Future<ResponseModel> getUpdateSetting(
      {int? userId, int? product, int? service}) {
    return _api.getUpdateSetting(
      userId: userId,
      product: product,
      service: service,
    );
  }
}
