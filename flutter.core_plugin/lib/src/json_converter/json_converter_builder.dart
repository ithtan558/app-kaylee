import 'package:core_plugin/core_plugin.dart';

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
///
///set YourAppJsonConverter() ở main() với function [JsonConverterBuilder.init()]
///void main() {
///  JsonConverterBuilder.init(YourAppJsonConverter());
///  runApp(YourApp());
///}
class JsonConverterBuilder {
  static JsonConverterBuilder? _builder;

  static JsonConverterBuilder get instance {
    assert(_builder.isNotNull,
        'please call JsonConverterBuilder.init() at your main.dart');
    return _builder!;
  }

  late JsonConverterFactory factory;

  static void init(JsonConverterFactory factory) {
    _builder ??= JsonConverterBuilder._(factory);
  }

  JsonConverterBuilder._(this.factory);
}
