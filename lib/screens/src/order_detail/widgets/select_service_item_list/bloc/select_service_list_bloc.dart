import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SelectServiceListBloc extends Cubit<LoadMoreModel<Service>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final ServService servService;
  int? cateId;
  final List<Service> _selectedServices = [];

  List<Service> get selectedServices => _selectedServices;
  final Brand brand;

  SelectServiceListBloc({
    required this.servService,
    List<Service>? initialData,
    required this.brand,
  }) : super(LoadMoreModel(items: [])) {
    if (initialData?.isNotEmpty ?? false) {
      _selectedServices.addAll(initialData!);
    }
  }

  void loadServices() {
    RequestHandler(
      request: servService.getServices(
        categoryId: cateId,
        limit: state.limit,
        page: state.page,
        brandIds: brand.id.toString(),
      ),
      onSuccess: ({message, result}) {
        final services = (result as PageData<Service>).items;
        for (var element in services ?? []) {
          Service? selected;
          try {
            selected = _selectedServices
                .singleWhere((selected) => selected.id == element.id);
          } catch (_) {}
          if (selected != null) {
            element.selected = true;
          }
        }
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

  void loadInitDataWithCate({int? cateId}) {
    changeTab(cateId: cateId);
  }

  void changeTab({int? cateId}) {
    if (cateId != null) {
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

  void select({required Service service}) {
    final item = state.items!.singleWhere(
      (element) => element.id == service.id,
    );
    item.selected = !service.selected;
    if (!item.selected) {
      _selectedServices.removeWhere((element) => element.id == service.id);
    } else {
      _selectedServices.add(item..quantity = 1);
    }
    emit(LoadMoreModel.copy(state));
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
    if (state.loading) return completeRefresh();

    state
      ..page = 1
      ..items = []
      ..loading = true;
    loadServices();
  }
}
