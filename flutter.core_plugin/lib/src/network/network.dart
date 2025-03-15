import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class Network {
  late Dio dio;

  Network({String baseUrl = '', int connectTimeout = 60 * 1000}) {
    dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: connectTimeout))
      ..interceptors.addAll([
        PrettyDioLogger(requestBody: true, responseHeader: true),
      ]);
  }
}

class ResponseTransformer extends DefaultTransformer {
  @override
  Future transformResponse(
      RequestOptions options, ResponseBody response) async {
    final responseBody = await super.transformResponse(options, response);
    if (responseBody is String) {
      try {
        return json.decode(responseBody);
      } catch (_) {}
    }
    return responseBody;
  }
}
