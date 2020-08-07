import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/brand/list/bloc/brand_list_bloc.dart';
import 'package:kaylee/screens/src/staff/list/bloc/staff_list_screen_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

abstract class KayleeFilterAction {
  void onApply();
}

class FilterScreen<T extends Filter> extends StatefulWidget {
  final KayleeFilterInterface<T> controller;

  FilterScreen({this.controller});

  @override
  _FilterScreenState<T> createState() => _FilterScreenState<T>();
}

class _FilterScreenState<T extends Filter> extends BaseState<FilterScreen<T>> {
  final searchTfController = TextEditingController();
  KayleeFilterAction action;

  @override
  void initState() {
    super.initState();
    searchTfController.text = widget.controller?.getFilter()?.keyword;
  }

  @override
  void dispose() {
    searchTfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          title: Strings.timKiemChonLoc,
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
              child: SearchInputField(
                hint: Strings.timKiemTheoTuKhoa,
                controller: searchTfController,
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
            action?.onApply();
            widget.controller?.updateFilter()?.keyword =
                searchTfController.text;
            widget.controller?.loadFilter();
            popScreen();
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
    widget.controller?.updateFilter()?.city = cityController.value;
    widget.controller?.updateFilter()?.district = districtController.value;
  }

  @override
  void initState() {
    super.initState();
    context.repository<_FilterScreenState>().action = this;
    cityController.value = widget.controller?.getFilter()?.city;
    districtController.value = widget.controller?.getFilter()?.district;
  }

  @override
  void dispose() {
    super.dispose();
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
    widget.controller?.updateFilter()?.brand = brandController.value;
    widget.controller?.updateFilter()?.city = cityController.value;
    widget.controller?.updateFilter()?.district = districtController.value;
  }

  @override
  void initState() {
    super.initState();
    context.repository<_FilterScreenState>().action = this;
    brandController.value = widget.controller?.getFilter()?.brand;
    cityController.value = widget.controller?.getFilter()?.city;
    districtController.value = widget.controller?.getFilter()?.district;
  }

  @override
  void dispose() {
    super.dispose();
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
