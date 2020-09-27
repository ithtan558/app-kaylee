import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class OrderDetailBloc extends Cubit<SingleModel<Order>> {
  final OrderService orderService;
  final Order order;
  OrderRequest request;

  OrderDetailBloc({this.orderService, this.order}) : super(SingleModel());

  void loadOrder() {}
}
