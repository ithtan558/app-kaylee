import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/services/services.dart';

class NotificationScreenBloc extends Cubit<SingleModel> {
  final NotificationService notificationService;

  NotificationScreenBloc({this.notificationService}) : super(SingleModel());

  void deleteAll() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: notificationService.deleteAll(),
      onSuccess: ({message, result}) {
        emit(DeleteAllState(loading: false, message: message));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void delete({models.Notification notification}) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: notificationService.delete(id: notification.id),
      onSuccess: ({message, result}) {
        emit(DeleteState(
          loading: false,
          message: message,
          item: notification,
        ));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }
}

class DeleteAllState extends SingleModel {
  DeleteAllState({
    Message message,
    bool loading,
  }) : super(loading: loading, message: message);
}

class DeleteState extends SingleModel<models.Notification> {
  DeleteState({
    Message message,
    models.Notification item,
    bool loading,
  }) : super(loading: loading, message: message, item: item);
}

class NotificationListBloc extends Cubit<LoadMoreModel<models.Notification>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final NotificationService notificationService;

  NotificationListBloc({this.notificationService}) : super(LoadMoreModel());

  String keyword;

  void search({String keyword}) {
    state.items = null;
    this.keyword = keyword;
    loadNotification();
  }

  void clearSearch() {
    search(keyword: null);
  }

  void loadNotification() {
    state.loading = true;
    RequestHandler(
      request: notificationService.getNotifications(
        page: this.state.page,
        limit: this.state.limit,
        keyword: this.keyword,
      ),
      onSuccess: ({message, result}) {
        final notifications = (result as models.Notifications).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(notifications)
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  void removeItem({models.Notification notification}) {
    state.items.removeWhere((e) => e.id == notification.id);
    emit(LoadMoreModel.copy(state));
  }

  void removeAll() {
    emit(LoadMoreModel.copy(state..items.clear()));
  }

  @override
  void loadMore() {
    state.page++;
    loadNotification();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void loadInitData() {
    loadNotification();
  }

  @override
  void refresh() {
    state
      ..page = 1
      ..items = [];
    renewCompleter();
    loadNotification();
  }
}
