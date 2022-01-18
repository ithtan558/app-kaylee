import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_cate_list_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_list_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_list_screen_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/tabs/supplier_info_tab.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/tabs/supplier_product_list_tab.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/widgets/supplier_info.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/widgets/supplier_info_switch_bar.dart';
import 'package:kaylee/widgets/src/cart_button.dart';
import 'package:kaylee/widgets/src/supplier_menu_float_button.dart';

class SupplierProdListScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => SupplierProdListScreenBloc(
            service: context.api.supplier,
            supplier: context.getArguments<Supplier>(),
          ),
        ),
        BlocProvider<SupplierProdCateListBloc>(
          create: (context) => SupplierProdCateListBloc(
            productService: context.api.product,
            supplier: context.getArguments<Supplier>(),
          ),
        ),
        BlocProvider<SupplierProdListBloc>(
          create: (context) => SupplierProdListBloc(
            productService: context.api.product,
            supplier: context.getArguments<Supplier>(),
          ),
        ),
      ], child: const SupplierProdListScreen());

  @visibleForTesting
  const SupplierProdListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SupplierProdListScreenState createState() => _SupplierProdListScreenState();
}

class _SupplierProdListScreenState extends KayleeState<SupplierProdListScreen> {
  SupplierProdCateListBloc get _categoryBloc =>
      context.bloc<SupplierProdCateListBloc>()!;

  SupplierProdListBloc get _productListBloc =>
      context.bloc<SupplierProdListBloc>()!;
  late StreamSubscription _cateBlocSub;

  SupplierProdListScreenBloc get _bloc =>
      context.bloc<SupplierProdListScreenBloc>()!;

  final _pageController = PageController();

  final _searchInputController = SearchInputFieldController();

  @override
  void initState() {
    super.initState();
    _bloc.getInfo();

    _cateBlocSub = _categoryBloc.stream.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: popScreen,
          );
        } else {
          ProdCate? category;
          try {
            category = state.items?.firstWhere((element) => true);
          } catch (_) {}
          _productListBloc.loadInitDataWithCate(category: category);
        }
      } else if (state.loading) {
        showLoading();
      }
    });

    _categoryBloc.loadProdCate();
  }

  @override
  void dispose() {
    _cateBlocSub.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: UnFocusWidget(
            child: Scaffold(
              appBar: _buildAppBar(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                        .copyWith(top: Dimens.px16),
                    child: const SupplierInfo(),
                  ),
                  Container(
                    height: Dimens.px1,
                    color: ColorsRes.textFieldBorder,
                    margin: const EdgeInsets.all(Dimens.px16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.px16),
                    child: SupplierInfoSwitchBar(
                      onTabChanged: (index) {
                        _pageController.jumpToPage(index);
                      },
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        RepositoryProvider<SearchInputFieldController>.value(
                            value: _searchInputController,
                            child: const SupplierProductListTab()),
                        const SupplierInfoTab(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<SupplierProdListScreenBloc, SingleModel<Supplier>>(
          builder: (context, state) {
            return SupplierMenuFloatButton(
              firstItem: MenuFloatItem(
                title: Strings.messenger,
                onTap: () {
                  final facebook = state.item?.facebook;
                  if (facebook.isNotNullAndEmpty) {
                    launch(facebook!);
                  }
                },
              ),
              secondItem: MenuFloatItem(
                title: Strings.zalo,
                onTap: () {
                  final zalo = state.item?.zalo;
                  if (zalo.isNotNullAndEmpty) {
                    launch(zalo!);
                  }
                },
              ),
            );
          },
        )
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return KayleeAppBar(
      titleWidget: KayleeTextField.search(
        controller: _searchInputController,
        hint: Strings.timTrongShop,
        inputPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.px12,
        ).copyWith(bottom: Dimens.px4),
        height: Dimens.px44,
        onDoneTyping: (value) {
          _productListBloc.search(value);
        },
        onClear: _productListBloc.clear,
      ),
      actions: const [
        CartButton(),
      ],
    );
  }
}
