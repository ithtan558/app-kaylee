import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

class KayleeJsonConverter extends JsonConverterFactory {
  @override
  T fromJson<T>(json) {
    if (T == LoginResult) {
      return LoginResult.fromJson(json) as T;
    } else if (T == UserInfo) {
      return UserInfo.fromJson(json) as T;
    } else if (T == VerifyPhoneResult) {
      return VerifyPhoneResult.fromJson(json) as T;
    } else if (T == Content) {
      return Content.fromJson(json) as T;
    } else if (T == VerifyOtpResult) {
      return VerifyOtpResult.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  toJson<T>(T json) {
    if (json is LoginResult) {
      return json.toJson();
    } else if (json is UserInfo) {
      return json.toJson();
    } else if (json is VerifyPhoneResult) {
      return json.toJson();
    } else if (json is Content) {
      return json.toJson();
    } else if (json is VerifyOtpResult) {
      return json.toJson();
    } else
      return json;
  }
}
