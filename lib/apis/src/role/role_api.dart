import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'role_api.g.dart';

@RestApi()
abstract class RoleApi {
  factory RoleApi(Dio dio) = _RoleApi;

  @GET('role/all')
  Future<ResponseModel<List<Role>>> getRoles();
}
