import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SelectServiceListBloc extends Cubit<LoadMoreModel<Service>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final ServService servService;
  int cateId;
  List<Service> selectedServices;

  SelectServiceListBloc({@required this.servService, this.selectedServices})
      : super(LoadMoreModel(items: []));

  void loadServices() {
    RequestHandler(
      request: servService.getServices(
        categoryId: this.cateId,
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final services = (result as Services).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(services)
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

  void loadInitDataWithCate({int cateId}) {
    changeTab(cateId: cateId);
  }

  void changeTab({int cateId}) {
    if (cateId.isNotNull) {
      ///user đổi category
      this.cateId = cateId;

      //reset page và item về ban đầu
      emit(LoadMoreModel.copy(state
        ..loading = true
        ..page = 1
        ..items = null));
      loadServices();
    }
  }

  void select({Service service}) {
    selectedServices ??= [];
    final selectedItem = selectedServices.singleWhere(
      (e) => e.id == service.id,
      orElse: () => null,
    );
    if (selectedItem.isNotNull) {
      selectedServices.remove(selectedItem);
    } else {
      selectedServices.add(selectedItem);
    }
  }

  @override
  void loadMore() {
    state.page++;
    loadServices();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void refresh() {
    super.refresh();
    state
      ..page = 1
      ..items = []
      ..loading = true;
    loadServices();
  }
}
