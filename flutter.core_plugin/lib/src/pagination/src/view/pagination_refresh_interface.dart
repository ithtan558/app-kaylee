import 'package:core_plugin/src/pagination/src/pagination_interface.dart';
import 'package:core_plugin/src/pagination/src/view/refresh/refresh_interface.dart';

abstract class PaginationRefreshInterface<Model>
    implements PaginationInterface<Model>, RefreshInterface {}
