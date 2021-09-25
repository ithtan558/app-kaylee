import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class CommissionService {
  Future<ResponseModel<Commission>> getDetail({
    String? startDate,
    String? endDate,
    int? userId,
  });

  Future<ResponseModel<PageData<CommissionOrder>>> getProductOfOrder({
    String? startDate,
    String? endDate,
    int? userId,
    int? page,
    int? limit,
  });

  Future<ResponseModel<PageData<CommissionOrder>>> getServiceOfOrder({
    String? startDate,
    String? endDate,
    int? userId,
    int? page,
    int? limit,
  });

  Future<ResponseModel<CommissionSetting>> getSetting({
    int? userId,
  });

  Future<ResponseModel> getUpdateSetting({
    int? userId,
    int? product,
    int? service,
  });
}
