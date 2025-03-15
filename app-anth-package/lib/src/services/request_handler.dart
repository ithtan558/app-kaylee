import 'dart:io';

import 'package:anth_package/anth_package.dart';

typedef OnFailed = void Function(ErrorType code, {Error? error});

///[result] có thể là object hoặc array
typedef OnSuccess = void Function({dynamic result, Message? message});

class RequestHandler {
  final Future request;
  final OnSuccess onSuccess;
  final OnFailed? onFailed;

  RequestHandler({
    required this.request,
    required this.onSuccess,
    this.onFailed,
  }) {
    _processing(request, onSuccess, onFailed);
  }

  _processing(
    Future request,
    OnSuccess onSuccess,
    OnFailed? onFailed,
  ) {
    request.then((response) {
      _handleOnResult(
          response: response, onSuccess: onSuccess, onFailed: onFailed);
    }, onError: (e, stackTrace) {
      _handleOnFailed(response: e, onFailed: onFailed);
    }).catchError((e) {
      _handleOnFailed(response: e, onFailed: onFailed);
    });
  }

  _handleOnResult(
      {required Object response,
      required OnSuccess onSuccess,
      OnFailed? onFailed}) {
    if (response is ResponseModel) {
      if (response.status) {
        if (response.data != null) {
          onSuccess(result: response.data, message: response.message);
        } else if (response.data == null && response.message != null) {
          onSuccess(message: response.message);
        } else {
          const errorCode = ErrorType.exception;
          const message = '"data" must be a Map or List';
          if (onFailed != null) {
            onFailed.call(errorCode, error: Error(message: message));
          }
        }
      } else {
        _handleOnFailed(response: response, onFailed: onFailed);
      }
    } else {
      const error = 'response type is not ResponseModel';
      _handleOnFailed(response: error, onFailed: onFailed);
    }
  }

  _handleOnFailed({required Object response, OnFailed? onFailed}) {
    if (onFailed == null) return;
    if (response is ResponseModel) {
      onFailed.call(ErrorType.failed, error: response.error);
    } else {
      switch (response.runtimeType) {
        case DioError:
          final err = response as DioError;
          if (err.type == DioErrorType.response && err.response?.data is Map) {
            final response =
                ResponseModel.fromJson(err.response!.data, (_) => null);
            if (err.response?.statusCode == HttpStatus.unauthorized) {
              onFailed(ErrorType.unauthorized, error: response.error);
            } else {
              onFailed(ErrorType.failed, error: response.error);
            }
          } else {
            onFailed(ErrorType.exception, error: Error(message: err.message));
          }
          break;
        default:
          onFailed(ErrorType.exception,
              error: Error(message: response.toString()));
          break;
      }
    }
  }
}
