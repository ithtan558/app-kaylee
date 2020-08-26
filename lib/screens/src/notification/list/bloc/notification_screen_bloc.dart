import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/services/services.dart';

class NotificationScreenBloc extends Cubit<LoadMoreModel<models.Notification>>
    implements LoadMoreInterface {
  final NotificationService notificationService;

  NotificationScreenBloc({this.notificationService}) : super(LoadMoreModel());

  String keyword;

  void search({String keyword}) {
    this.keyword = keyword;
    loadNotification();
  }

  void refresh() {
    loadNotification();
  }

  void loadNotification() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: notificationService.getNotifications(
        page: this.state.page,
        limit: this.state.limit,
        keyword: this.keyword,
      ),
      onSuccess: ({message, result}) {
        final notifications = (result as models.Notifications).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..items = notifications
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void loadMore() {
    state.page++;
    loadNotification();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;
}
