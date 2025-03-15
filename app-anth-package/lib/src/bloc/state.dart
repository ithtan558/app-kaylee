import 'package:anth_package/anth_package.dart';

class ErrorState {
  ErrorType code;
  Error? error;

  ErrorState(this.code, {this.error});
}

class LoadingState {}

class LoadingDialogState {}

class InitState {}

class MessageErrorState {
  String message;

  MessageErrorState(this.message);
}

class BaseModel {
  ErrorType? code;
  Error? error;
  Message? message;
  bool loading;

  BaseModel({this.code, this.error, this.loading = false, this.message});
}

class SingleModel<T> extends BaseModel with _BaseModelMixin<SingleModel<T>> {
  T? item;

  SingleModel({
    this.item,
    ErrorType? code,
    Error? error,
    bool loading = false,
    Message? message,
  }) : super(code: code, error: error, loading: loading, message: message);

  SingleModel.copy(SingleModel<T> old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..error = old.error
      ..code = old.code
      ..message = old.message;
  }

  @override
  SingleModel<T> copy({ErrorType? code, Error? error, Message? message}) {
    return SingleModel<T>(
      code: code ?? this.code,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  SingleModel<T> _updateState(
      {ErrorType? code, Error? error, Message? message}) {
    return SingleModel<T>(
      code: code,
      error: error,
      message: message,
    );
  }
}

class LoadMoreModel<T> extends BaseModel
    with _BaseModelMixin<LoadMoreModel<T>> {
  int page;
  int limit;
  List<T>? items;

  bool get ended => items == null ? false : (items!.length < page * limit);

  void addAll(List<T>? items) {
    if (this.items != null && this.items!.isNotEmpty) {
      this.items!.addAll(items ?? []);
    } else {
      this.items = List.of(items ?? []);
    }
  }

  LoadMoreModel({
    this.items,
    this.page = 1,
    this.limit = 10,
    bool loading = false,
    ErrorType? code,
    Error? error,
    Message? message,
  }) : super(code: code, error: error, loading: loading, message: message);

  LoadMoreModel.copy(LoadMoreModel<T> old, {this.page = 1, this.limit = 10}) {
    this
      ..items = old.items
      ..loading = old.loading
      ..page = old.page
      ..limit = old.limit
      ..error = old.error
      ..code = old.code
      ..message = old.message;
  }

  @override
  LoadMoreModel<T> copy({ErrorType? code, Error? error, Message? message}) {
    return LoadMoreModel<T>(
      code: code ?? this.code,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  LoadMoreModel<T> _updateState(
      {ErrorType? code, Error? error, Message? message}) {
    return LoadMoreModel<T>(
      code: code,
      error: error,
      message: message,
    );
  }
}

mixin _BaseModelMixin<Model> {
  Model copy({ErrorType? code, Error? error, Message? message});

  ///update state khi load success
  Model success({Message? message}) => _updateState(message: message);

  ///update state khi load failed
  Model failure({required ErrorType code, Error? error}) =>
      _updateState(code: code, error: error);

  Model _updateState({ErrorType? code, Error? error, Message? message});
}
