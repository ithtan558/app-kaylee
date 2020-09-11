import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/brand/list/bloc/brand_list_bloc.dart';
import 'package:kaylee/screens/src/commission/list/bloc/bloc.dart';
import 'package:kaylee/screens/src/customer/list/bloc/customer_list_screen_bloc.dart';
import 'package:kaylee/screens/src/product/list/bloc/prod_list_bloc.dart';
import 'package:kaylee/screens/src/service/list/bloc/service_list_bloc.dart';
import 'package:kaylee/screens/src/staff/list/bloc/staff_list_screen_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

abstract class KayleeFilterAction {
  ///khi call function này, chỉ thay đổi [KayleeFilterInterface] khi controller.value bên trong mỗi view != null
  ///vì không muốn tạo Object [Filter] nếu controller.value == null
  void onApply();

  void onReset();
}

class FilterScreen<T extends Filter> extends StatefulWidget {
  final KayleeFilterInterface<T> controller;

  FilterScreen({this.controller});

  @override
  _FilterScreenState<T> createState() => _FilterScreenState<T>();
}

class _FilterScreenState<T extends Filter> extends BaseState<FilterScreen<T>> {
  final searchTfController = SearchInputFieldController();
  final searchFocus = FocusNode();
  KayleeFilterAction action;

  @override
  void initState() {
    super.initState();
    searchTfController.keyword = widget.controller?.getFilter()?.keyword;
  }

  @override
  void dispose() {
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          title: Strings.timKiemChonLoc,
          actions: <Widget>[
            KayleeAppBarAction.hyperText(
              title: Strings.xoa,
              onTap: () {
                action?.onReset();
                searchFocus.unfocus();
                searchTfController.clear();
                widget.controller.resetFilter();
              },
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimens.px16, left: Dimens.px16, right: Dimens.px16),
              child: KayleeText.hyper16W500(Strings.timKiem.toUpperCase()),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.px16, right: Dimens.px16, top: Dimens.px8),
              child: KayleeTextField.search(
                hint: Strings.timKiemTheoTuKhoa,
                focusNode: searchFocus,
                controller: searchTfController,
                onClear: () {
                  widget.controller.getFilter().keyword = null;
                },
              ),
            ),
            Container(
                height: Dimens.px1,
                margin: const EdgeInsets.symmetric(vertical: Dimens.px16),
                decoration:
                    const BoxDecoration(color: ColorsRes.textFieldBorder)),
            Padding(
              padding:
                  const EdgeInsets.only(left: Dimens.px16, right: Dimens.px16),
              child: KayleeText.hyper16W500(Strings.chonLoc.toUpperCase()),
            ),
            MultiRepositoryProvider(providers: [
              RepositoryProvider<_FilterScreenState>.value(value: this),
            ], child: getFilterView(controller: widget.controller)),
          ],
        ),
        bottom: KayLeeRoundedButton.normal(
          text: Strings.apDung,
          margin: const EdgeInsets.only(
              bottom: Dimens.px16, left: Dimens.px16, right: Dimens.px16),
          onPressed: () {
            ///nếu keyword not empty
            ///thì set keyword cho filter
            if (searchTfController.keyword.isNotNullAndEmpty) {
              widget.controller?.updateFilter()?.keyword =
                  searchTfController.keyword;
            }
            action?.onApply();
            popScreen(resultBundle: Bundle(true));
          },
        ),
      ),
    );
  }

  Widget getFilterView({KayleeFilterInterface<T> controller}) {
    switch (T) {
      case BrandFilter:
        return BrandFilterView(
          controller: controller as KayleeFilterInterface<BrandFilter>,
        );
      case StaffFilter:
        return StaffFilterView(
          controller: controller as KayleeFilterInterface<StaffFilter>,
        );
      case CustomerFilter:
        return CustomerFilterView(
          controller: controller as KayleeFilterInterface<CustomerFilter>,
        );
      case ServiceFilter:
        return ServiceFilterView(
          controller: controller as KayleeFilterInterface<ServiceFilter>,
        );
      case ProductFilter:
        return ProductFilterView(
          controller: controller as KayleeFilterInterface<ProductFilter>,
        );
      case CommissionFilter:
        return CommissionFilterView(
          controller: controller as KayleeFilterInterface<CommissionFilter>,
        );
      default:
        return Container();
    }
  }
}

class BrandFilterView extends StatefulWidget {
  final KayleeFilterInterface<BrandFilter> controller;

  BrandFilterView({this.controller});

  @override
  _BrandFilterViewState createState() => _BrandFilterViewState();
}

class _BrandFilterViewState extends BaseState<BrandFilterView>
    implements KayleeFilterAction {
  final cityController = PickInputController<City>();
  final districtController = PickInputController<District>();

  @override
  void onApply() {
    if (cityController.value != null) {
      widget.controller?.updateFilter()?.city = cityController.value;
    }
    if (districtController.value != null) {
      widget.controller?.updateFilter()?.district = districtController.value;
    }
  }

  @override
  void onReset() {
    cityController.clear();
    districtController.clear();
  }

  @override
  void initState() {
    super.initState();
    context.repository<_FilterScreenState>().action = this;
    cityController.value = widget.controller?.getFilter()?.city;
    districtController.value = widget.controller?.getFilter()?.district;
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<KayleePickerTextFieldModel>(
      create: (context) => KayleePickerTextFieldModel(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.px16, vertical: Dimens.px16),
            child: KayleePickerTextField<City>(
              title: Strings.tinhTpHint,
              controller: cityController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
            child: KayleePickerTextField<District>(
              title: Strings.quan,
              controller: districtController,
            ),
          ),
        ],
      ),
    );
  }
}

class StaffFilterView extends StatefulWidget {
  final KayleeFilterInterface<StaffFilter> controller;

  StaffFilterView({this.controller});

  @override
  _StaffFilterViewState createState() => _StaffFilterViewState();
}

class _StaffFilterViewState extends BaseState<StaffFilterView>
    implements KayleeFilterAction {
  final brandController = PickInputController<Brand>();
  final cityController = PickInputController<City>();
  final districtController = PickInputController<District>();

  @override
  void onApply() {
    if (brandController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.brand = brandController.value;
    }
    if (cityController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.city = cityController.value;
    }
    if (districtController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.district = districtController.value;
    }
  }

  @override
  void onReset() {
    brandController.clear();
    cityController.clear();
    districtController.clear();
  }

  @override
  void initState() {
    super.initState();
    context
        .repository<_FilterScreenState>()
        .action = this;
    brandController.value = widget.controller
        ?.getFilter()
        ?.brand;
    cityController.value = widget.controller
        ?.getFilter()
        ?.city;
    districtController.value = widget.controller
        ?.getFilter()
        ?.district;
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<KayleePickerTextFieldModel>(
      create: (context) => KayleePickerTextFieldModel(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.px16, vertical: Dimens.px16),
            child: KayleePickerTextField<Brand>(
              title: Strings.cuaHangApDung,
              controller: brandController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
            child: KayleePickerTextField<City>(
              title: Strings.tinhTpHint,
              controller: cityController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
            child: KayleePickerTextField<District>(
              title: Strings.quan,
              controller: districtController,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerFilterView extends StatefulWidget {
  final KayleeFilterInterface<CustomerFilter> controller;

  CustomerFilterView({this.controller});

  @override
  _CustomerFilterViewState createState() => _CustomerFilterViewState();
}

class _CustomerFilterViewState extends BaseState<CustomerFilterView>
    implements KayleeFilterAction {
  final typeController = PickInputController<CustomerType>();
  final cityController = PickInputController<City>();
  final districtController = PickInputController<District>();

  @override
  void onApply() {
    if (typeController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.type = typeController.value;
    }
    if (cityController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.city = cityController.value;
    }
    if (districtController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.district = districtController.value;
    }
  }

  @override
  void onReset() {
    typeController.clear();
    cityController.clear();
    districtController.clear();
  }

  @override
  void initState() {
    super.initState();
    context
        .repository<_FilterScreenState>()
        .action = this;
    typeController.value = widget.controller
        ?.getFilter()
        ?.type;
    cityController.value = widget.controller
        ?.getFilter()
        ?.city;
    districtController.value = widget.controller
        ?.getFilter()
        ?.district;
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<KayleePickerTextFieldModel>(
      create: (context) => KayleePickerTextFieldModel(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.px16, vertical: Dimens.px16),
            child: KayleePickerTextField<CustomerType>(
              title: Strings.phanLoai,
              controller: typeController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
            child: KayleePickerTextField<City>(
              title: Strings.tinhTpHint,
              controller: cityController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
            child: KayleePickerTextField<District>(
              title: Strings.quan,
              controller: districtController,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceFilterView extends StatefulWidget {
  final KayleeFilterInterface<ServiceFilter> controller;

  ServiceFilterView({this.controller});

  @override
  _ServiceFilterViewState createState() => _ServiceFilterViewState();
}

class _ServiceFilterViewState extends BaseState<ServiceFilterView>
    implements KayleeFilterAction {
  final categoryController = PickInputController<ServiceCate>();
  final brandController = PickInputController<Brand>();
  final priceController = KayleePriceRangeController();

  @override
  void onApply() {
    if (categoryController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.category = categoryController.value;
    }
    if (brandController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.brand = brandController.value;
    }

    if (priceController.startPrice.isNotNull) {
      widget.controller
          ?.updateFilter()
          ?.startPrice =
          priceController.startPrice;
    }
    if (priceController.endPrice.isNotNull) {
      widget.controller
          ?.updateFilter()
          ?.endPrice = priceController.endPrice;
    }
  }

  @override
  void onReset() {
    categoryController.clear();
    brandController.clear();
    priceController.reset();
  }

  @override
  void initState() {
    super.initState();
    context
        .repository<_FilterScreenState>()
        .action = this;
    categoryController.value = widget.controller
        ?.getFilter()
        ?.category;
    brandController.value = widget.controller
        ?.getFilter()
        ?.brand;
    priceController.startPrice = widget.controller
        ?.getFilter()
        ?.startPrice;
    priceController.endPrice = widget.controller
        ?.getFilter()
        ?.endPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.px16, vertical: Dimens.px16),
          child: KayleePriceRange(
            controller: priceController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.px16, vertical: Dimens.px16),
          child: KayleePickerTextField<ServiceCate>(
            title: Strings.danhMuc,
            controller: categoryController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
          child: KayleePickerTextField<Brand>(
            title: Strings.cuaHangApDung,
            controller: brandController,
          ),
        ),
      ],
    );
  }
}

class ProductFilterView extends StatefulWidget {
  final KayleeFilterInterface<ProductFilter> controller;

  ProductFilterView({this.controller});

  @override
  _ProductFilterViewState createState() => _ProductFilterViewState();
}

class _ProductFilterViewState extends BaseState<ProductFilterView>
    implements KayleeFilterAction {
  final categoryController = PickInputController<ProdCate>();
  final brandController = PickInputController<Brand>();
  final priceController = KayleePriceRangeController();

  @override
  void onApply() {
    if (categoryController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.category = categoryController.value;
    }
    if (brandController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.brand = brandController.value;
    }

    if (priceController.startPrice.isNotNull) {
      widget.controller
          ?.updateFilter()
          ?.startPrice =
          priceController.startPrice;
    }
    if (priceController.endPrice.isNotNull) {
      widget.controller
          ?.updateFilter()
          ?.endPrice = priceController.endPrice;
    }
  }

  @override
  void onReset() {
    categoryController.clear();
    brandController.clear();
    priceController.reset();
  }

  @override
  void initState() {
    super.initState();
    context
        .repository<_FilterScreenState>()
        .action = this;
    categoryController.value = widget.controller
        ?.getFilter()
        ?.category;
    brandController.value = widget.controller
        ?.getFilter()
        ?.brand;
    priceController.startPrice = widget.controller
        ?.getFilter()
        ?.startPrice;
    priceController.endPrice = widget.controller
        ?.getFilter()
        ?.endPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.px16, vertical: Dimens.px16),
          child: KayleePriceRange(
            controller: priceController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.px16, vertical: Dimens.px16),
          child: KayleePickerTextField<ProdCate>(
            title: Strings.danhMuc,
            controller: categoryController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
          child: KayleePickerTextField<Brand>(
            title: Strings.cuaHangApDung,
            controller: brandController,
          ),
        ),
      ],
    );
  }
}

class CommissionFilterView extends StatefulWidget {
  final KayleeFilterInterface<CommissionFilter> controller;

  CommissionFilterView({this.controller});

  @override
  _CommissionFilterViewState createState() => _CommissionFilterViewState();
}

class _CommissionFilterViewState extends BaseState<CommissionFilterView>
    implements KayleeFilterAction {
  final brandController = PickInputController<Brand>();
  final cityController = PickInputController<City>();
  final districtController = PickInputController<District>();

  @override
  void onApply() {
    if (brandController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.brand = brandController.value;
    }
    if (cityController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.city = cityController.value;
    }
    if (districtController.value != null) {
      widget.controller
          ?.updateFilter()
          ?.district = districtController.value;
    }
  }

  @override
  void onReset() {
    brandController.clear();
    cityController.clear();
    districtController.clear();
  }

  @override
  void initState() {
    super.initState();
    context
        .repository<_FilterScreenState>()
        .action = this;
    brandController.value = widget.controller
        ?.getFilter()
        ?.brand;
    cityController.value = widget.controller
        ?.getFilter()
        ?.city;
    districtController.value = widget.controller
        ?.getFilter()
        ?.district;
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<KayleePickerTextFieldModel>(
      create: (context) => KayleePickerTextFieldModel(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.px16, vertical: Dimens.px16),
            child: KayleePickerTextField<Brand>(
              title: Strings.diaDiemPhucVu,
              controller: brandController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
            child: KayleePickerTextField<City>(
              title: Strings.tinhTpHint,
              controller: cityController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimens.px16, right: Dimens.px16, bottom: Dimens.px16),
            child: KayleePickerTextField<District>(
              title: Strings.quan,
              controller: districtController,
            ),
          ),
        ],
      ),
    );
  }
}
