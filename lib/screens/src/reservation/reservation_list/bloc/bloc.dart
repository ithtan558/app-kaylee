import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/utils/utils.dart';

class ReservationFilter extends Filter {
  ReservationStatus? status;
  Brand? brand;
}

class ReservationListBloc extends Cubit<LoadMoreModel<Reservation>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface, KayleeFilterInterface<ReservationFilter> {
  final ReservationService service;

  ReservationListBloc({required this.service}) : super(LoadMoreModel());
  ReservationFilter? _filter;
  DateTime? date;

  void loadReservations() {
    state.loading = true;
    RequestHandler(
      request: service.getReservations(
        keyword: _filter?.keyword,
        status: _filter?.status?.index != null
            ? (_filter!.status!.index + 1)
            : null,
        brandId: _filter?.brand?.id,
        datetime: date?.toFormatString(pattern: dateFormat),
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final reservations = (result as PageData<Reservation>).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(reservations)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void loadReservationsByDate({required DateTime date}) {
    this.date = date;
    emit(LoadMoreModel.copy(state
      ..page = 1
      ..items = null
      ..loading = true));
    loadReservations();
  }

  @override
  void loadInitData() {
    loadReservations();
  }

  @override
  ReservationFilter? getFilter() {
    return _filter;
  }

  @override
  void loadFilter() {
      emit(LoadMoreModel.copy(state
        ..items = null
        ..page = 1));
      loadReservations();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void loadMore() {
    state.page++;
    loadReservations();
  }

  @override
  void resetFilter() {
    _filter = null;
  }

  @override
  ReservationFilter updateFilter() {
    if (isEmptyFilter) _filter = ReservationFilter();
    return _filter!;
  }

  @override
  void refresh() {
    super.refresh();
    if (state.loading) return completeRefresh();

    state
      ..page = 1
      ..items = [];
    loadReservations();
  }

  @override
  bool get isEmptyFilter => _filter == null;
}
