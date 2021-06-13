import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/customer/create_new/create_new_customer_screen.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_customer/bloc/select_customer_bloc.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_customer/select_customer_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectCustomerDialog extends StatefulWidget {
  static Widget newInstance({required ValueSetter<Customer> onSelect}) =>
      BlocProvider(
        create: (context) => SelectCustomerBloc(
          customerService: context.network.provideCustomerService(),
        ),
        child: SelectCustomerDialog._(onSelect: onSelect),
      );
  final ValueSetter<Customer> onSelect;

  SelectCustomerDialog._({required this.onSelect});

  @override
  _SelectCustomerDialogState createState() => _SelectCustomerDialogState();
}

class _SelectCustomerDialogState extends KayleeState<SelectCustomerDialog> {
  SelectCustomerBloc get selectCustomerBloc =>
      context.bloc<SelectCustomerBloc>()!;
  final searchTfController = SearchInputFieldController();

  @override
  void initState() {
    super.initState();
    selectCustomerBloc.loadCustomer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.px16),
              child: KayleeText.normal18W700(
                Strings.danhSachKH,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                  .copyWith(bottom: Dimens.px8),
              child: KayleeTextField.search(
                hint: Strings.hintTimKhachHangTheoTenHoacSdt,
                controller: searchTfController,
                onDoneTyping: (value) {
                  selectCustomerBloc.loadCustomer(keyword: value);
                },
                onClear: () {
                  selectCustomerBloc.loadCustomer();
                },
              ),
            ),
            Expanded(child:
                BlocBuilder<SelectCustomerBloc, SingleModel<List<Customer>>>(
              builder: (context, state) {
                if (state.loading)
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
                    child: KayleeLoadingIndicator(),
                  );
                return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                        .copyWith(top: Dimens.px8, bottom: Dimens.px8),
                    itemBuilder: (context, index) {
                      final item = state.item!.elementAt(index);
                      return SelectCustomerItem(
                        customer: item,
                        onSelect: () {
                          widget.onSelect.call(item);
                          context.pop();
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: Dimens.px8,
                        ),
                    itemCount: state.item?.length ?? 0);
              },
            )),
            KayLeeRoundedButton.normal(
              margin: const EdgeInsets.all(Dimens.px16),
              text: Strings.taoKhachHangMoi,
              onPressed: () {
                popScreen();
                context.push(PageIntent(
                    screen: CreateNewCustomerScreen,
                    bundle: Bundle(NewCustomerScreenData(
                      openFrom: CustomerScreenOpenFrom.cashier,
                    ))));
              },
            )
          ],
        ),
      ),
    );
  }
}
