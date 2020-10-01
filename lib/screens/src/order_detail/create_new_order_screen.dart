import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart' hide OrderItem;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/bloc/order_detail_bloc.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_customer_field.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_order_item_list.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewOrderScreenData {
  final OrderScreenOpenFrom openFrom;

  NewOrderScreenData({this.openFrom});
}

enum OrderScreenOpenFrom { detailButton, addNewButton }

class CreateNewOrderScreen extends StatefulWidget {
  static Widget newInstance() => RepositoryProvider(
    create: (context) => CartModule.init(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => OrderDetailBloc(
                orderService: context.network.provideOrderService(),
                order: context.getArguments<Order>(),
                cart: context.cart,
              ),
            ),
            BlocProvider(create: (context) => CartBloc()),
          ],
          child: CreateNewOrderScreen._(),
        ),
      );

  CreateNewOrderScreen._();

  @override
  _CreateNewOrderScreenState createState() => _CreateNewOrderScreenState();
}

class _CreateNewOrderScreenState extends BaseState<CreateNewOrderScreen> {
  OrderScreenOpenFrom openFrom;
  final brandController = PickInputController<Brand>();
  final employeeController = PickInputController<Employee>();
  final customerController = SelectCustomerController();

  @override
  void initState() {
    super.initState();
    final data = context.bundle.args as NewOrderScreenData;
    openFrom = data?.openFrom;
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == OrderScreenOpenFrom.detailButton
              ? Strings.chinhSuaDonHang
              : Strings.taoDonHangMoi,
          actionTitle: openFrom == OrderScreenOpenFrom.detailButton
              ? Strings.luu
              : Strings.tao,
          onActionClick: () {},
        ),
        body: BlocConsumer<OrderDetailBloc, SingleModel<OrderRequest>>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimens.px16),
                    child: SelectCustomerField(
                      controller: customerController,
                      onSelect: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.px16,
                        right: Dimens.px16,
                        bottom: Dimens.px16),
                    child: KayleePickerTextField(
                      title: Strings.chiNhanh,
                      hint: Strings.chonChiNhanhTrongDs,
                      controller: brandController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.px16,
                        right: Dimens.px16,
                        bottom: Dimens.px16),
                    child: KayleePickerTextField(
                      title: Strings.nhanVienThucThien,
                      hint: Strings.chonNhanVienTrongDs,
                      controller: employeeController,
                    ),
                  ),
                  SelectOrderItemList(),
                  LabelDividerView(title: Strings.giamGia),
                  Padding(
                    padding: const EdgeInsets.all(Dimens.px16),
                    child: KayleeTextField.unitSelection(
                      hint: '0',
                    ),
                  ),
                  KayLeeRoundedButton.normal(
                    text: Strings.thanhToan,
                    margin: const EdgeInsets.all(Dimens.px8),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
