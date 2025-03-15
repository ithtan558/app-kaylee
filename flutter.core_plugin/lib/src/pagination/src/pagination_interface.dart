import 'pagination_mixin.dart';

///implement bởi [PaginationMixin]
abstract class PaginationInterface<Model> {
  void nextPage();

  List<Model>? get items;

  ///[ended] = true nếu đã load tới cuối page
  ///= false nếu list đang ở trạng thái ban đầu, chưa load api
  bool get ended;

  int get page;

  int get limit;

  ///[refreshing] = true nếu đang refresh
  bool get refreshing;

  ///[loading] = true nếu đang loading
  bool get loading;

  ///[isFirstTimeLoad] = true nếu đang ở trạng thái load lần đầu tiên
  ///nếu load xong lần đầu tiên sẽ chuyển thành false
  ///chỉ đc update khi call [reset] (lúc này sẽ trở lại là true)
  bool? get isFirstTimeLoad;

  ///reset list về rỗng
  ///và đặt trạng thái của instance về ban đầu như lúc khởi tạo
  void reset();
}
