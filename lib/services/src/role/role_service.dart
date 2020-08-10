import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'role_service.g.dart';

@RestApi()
abstract class RoleService {
  factory RoleService(Dio dio) = _RoleService;

  @GET('role/all')
  Future<ResponseModel<Role>> getRoles();
}
