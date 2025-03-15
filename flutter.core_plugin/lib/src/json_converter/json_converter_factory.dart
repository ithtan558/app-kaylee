///cách sử dụng
///Tạo sub-class extend JsonConverterFactory
///class YourAppJsonConverter extends JsonConverterFactory {
///  @override
///  T fromJson<T>(json) {
///    if (T == YourModel) {
///      return YourModel.fromJson(json) as T;
///    }
///    return json as T;
///  }
//
///  @override
///  toJson<T>(T json) {
///    if (json is YourModel) {
///      return json.toJson();
///    } else
///      return json;
///  }
///}
abstract class JsonConverterFactory {
  T fromJson<T>(dynamic json);

  dynamic toJson<T>(T object);
}
