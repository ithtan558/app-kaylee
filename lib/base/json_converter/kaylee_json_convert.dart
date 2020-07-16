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
    } else if (T == City) {
      return City.fromJson(json) as T;
    } else if (T == District) {
      return District.fromJson(json) as T;
    } else if (T == Ward) {
      return Ward.fromJson(json) as T;
    } else if (T == Supplier) {
      return Supplier.fromJson(json) as T;
    } else if (T == Suppliers) {
      return Suppliers.fromJson(json) as T;
    } else if (T == ProdCate) {
      return ProdCate.fromJson(json) as T;
    } else if (T == Product) {
      return Product.fromJson(json) as T;
    } else if (T == Products) {
      return Products.fromJson(json) as T;
    } else if (T == NotificationCount) {
      return NotificationCount.fromJson(json) as T;
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
    } else if (json is City) {
      return json.toJson();
    } else if (json is District) {
      return json.toJson();
    } else if (json is Ward) {
      return json.toJson();
    } else if (json is Supplier) {
      return json.toJson();
    } else if (json is Suppliers) {
      return json.toJson();
    } else if (json is ProdCate) {
      return json.toJson();
    } else if (json is Product) {
      return json.toJson();
    } else if (json is Products) {
      return json.toJson();
    } else if (json is NotificationCount) {
      return json.toJson();
    } else
      return json;
  }
}
