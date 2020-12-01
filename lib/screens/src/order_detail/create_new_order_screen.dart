import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart' hide OrderItem;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/cashier_tab.dart';
import 'package:kaylee/screens/src/home/tabs/history/history_tab.dart';
import 'package:kaylee/screens/src/order_detail/bloc/order_detail_bloc.dart';
import 'package:kaylee/screens/src/order_detail/widgets/payment_method_dialog.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_customer_field.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_order_item_list.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewOrderScreenData {
  final OrderScreenOpenFrom openFrom;
  final Order order;
  final Reservation reservation;

  NewOrderScreenData({
    this.openFrom,
    this.order,
    this.reservation,
  });
}

enum OrderScreenOpenFrom { detailButton, addNewButton, addNewFromReservation }

class CreateNewOrderScreen extends StatefulWidget {
  static Widget newInstance() => RepositoryProvider(
        create: (context) => CartModule.init(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => OrderDetailBloc(
                orderService: context.network.provideOrderService(),
                order: context.getArguments<NewOrderScreenData>()?.order,
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

class _CreateNewOrderScreenState extends KayleeState<CreateNewOrderScreen> {
  OrderScreenOpenFrom openFrom;
  final brandController = PickInputController<Brand>();
  final employeeController = PickInputController<Employee>();
  final customerController = SelectCustomerController();
  final discountController = TextEditingController();
  final pickerTextFieldModel = KayleePickerTextFieldModel();

  CartModule get _cart => context.cart;

  OrderRequest get _order => _cart.getOrder();

  OrderDetailBloc get _bloc => context.bloc<OrderDetailBloc>();

  CartBloc get _cartBloc => context.bloc<CartBloc>();
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    _sub = _bloc.listen((state) {
      if (state.loading) {
        primaryFocus.unfocus();
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
        } else if (state is UpdateOrderState) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>().reload(widget: CashierTab);
            },
          );
        } else if (state is CreateOrderState) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: popScreen,
            onDismiss: () {
              context.bloc<ReloadBloc>().reload(widget: CashierTab);
              popScreen();
            },
          );
        } else if (state is DoPaymentOrderState) {
          showKayleeAlertDialog(
            context: context,
            view: KayleeAlertDialogView(
              title: state.message.title,
              content: state.message.content,
              actions: [
                KayleeAlertDialogAction(
                  title: Strings.inHoaDon,
                  isDefaultAction: true,
                  onPressed: popScreen,
                ),
                KayleeAlertDialogAction(
                  title: Strings.veDsDonHang,
                  onPressed: popScreen,
                ),
              ],
            ),
            onDismiss: () {
              context.bloc<ReloadBloc>().reload(widget: CashierTab);
              context.bloc<ReloadBloc>().reload(widget: HistoryTab);
              popScreen();
            },
          );
        }
      }
    });

    final data = context.getArguments<NewOrderScreenData>();
    openFrom = data?.openFrom;

    if (openFrom == OrderScreenOpenFrom.detailButton) {
      _bloc.get();
    } else if (openFrom == OrderScreenOpenFrom.addNewFromReservation) {
      _cart.updateOrderInfo(OrderRequest(
          customer: data.reservation.customer, brand: data.reservation.brand));
      customerController.customer = _order.customer;
      brandController.value = _order.brand;
    }
  }

  @override
  void dispose() {
    discountController.dispose();
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar.hyperTextAction(
          title: openFrom == OrderScreenOpenFrom.addNewButton ||
                  openFrom == OrderScreenOpenFrom.addNewFromReservation
              ? Strings.taoDonHangMoi
              : Strings.chinhSuaDonHang,
          actionTitle: openFrom == OrderScreenOpenFrom.addNewButton ||
              openFrom == OrderScreenOpenFrom.addNewFromReservation
              ? Strings.tao
              : Strings.luu,
          onActionClick: () {
            if (openFrom == OrderScreenOpenFrom.addNewButton ||
                openFrom == OrderScreenOpenFrom.addNewFromReservation) {
              _cart.updateOrderInfo(OrderRequest(
                brand: brandController.value,
                employee: employeeController.value,
              ));
              _bloc.create();
            } else {
              _cart.updateOrderInfo(OrderRequest(
                brand: brandController.value,
                employee: employeeController.value,
              ));
              _bloc.update();
            }
          },
        ),
        body: BlocConsumer<OrderDetailBloc, SingleModel<OrderRequest>>(
          listener: (context, state) {
            customerController.customer = _order?.customer;
            brandController.value = _order?.brand;
            employeeController.value = _order?.employee;
            discountController.text = _order?.discount?.toString();
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimens.px16),
                          child: SelectCustomerField(
                            controller: customerController,
                            onSelect: (value) {
                              _cart.updateOrderInfo(OrderRequest(
                                customer: customerController.customer,
                              ));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimens.px16,
                              right: Dimens.px16,
                              bottom: Dimens.px16),
                          child: RepositoryProvider.value(
                            value: pickerTextFieldModel,
                            child: KayleePickerTextField(
                              title: Strings.chiNhanh,
                              hint: Strings.chonChiNhanhTrongDs,
                              controller: brandController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimens.px16,
                              right: Dimens.px16,
                              bottom: Dimens.px16),
                          child: RepositoryProvider.value(
                            value: pickerTextFieldModel,
                            child: KayleePickerTextField(
                              title: Strings.nhanVienThucThien,
                              hint: Strings.chonNhanVienTrongDs,
                              controller: employeeController,
                            ),
                          ),
                        ),
                        SelectOrderItemList(),
                        if (openFrom !=
                            OrderScreenOpenFrom.addNewFromReservation) ...[
                          LabelDividerView(title: Strings.giamGia),
                          Padding(
                            padding: const EdgeInsets.all(Dimens.px16),
                            child: KayleeTextField.unitSelection(
                              hint: '0',
                              controller: discountController,
                              textInputAction: TextInputAction.done,
                              onChange: (value) {
                                _cart.updateOrderInfo(OrderRequest(
                                  discount: int.tryParse(value),
                                ));
                                _cartBloc.updateCart();
                              },
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                if (openFrom != OrderScreenOpenFrom.addNewFromReservation)
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (_order?.cartItems.isNullOrEmpty)
                        return KayLeeRoundedButton.button3(
                          text: Strings.thanhToan,
                          margin: const EdgeInsets.all(Dimens.px8),
                        );
                      return KayLeeRoundedButton.normal(
                        text: Strings.thanhToan,
                        margin: const EdgeInsets.all(Dimens.px8),
                        onPressed: () {
                          showKayleeDialog(
                            context: context,
                            showShadow: true,
                            child: RepositoryProvider.value(
                              value: _order,
                              child: PaymentMethodDialog.newInstance(
                                onConfirm: () {
                                  if (openFrom ==
                                      OrderScreenOpenFrom.detailButton) {
                                    _bloc.payOrder();
                                  } else if (openFrom ==
                                      OrderScreenOpenFrom.addNewButton) {
                                    _cart.updateOrderInfo(OrderRequest(
                                      brand: brandController.value,
                                      employee: employeeController.value,
                                    ));
                                    _bloc.createOrderAndPay();
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
