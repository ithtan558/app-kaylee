import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class BrandSelectionButton extends StatefulWidget {
  final ValueChanged<Brand>? onChanged;

  BrandSelectionButton({this.onChanged});

  @override
  _BrandSelectionButtonState createState() => _BrandSelectionButtonState();
}

class _BrandSelectionButtonState extends KayleeState<BrandSelectionButton> {
  Brand? currentValue;
  late Brand selectedBrand;

  @override
  void initState() {
    super.initState();
    selectedBrand = Brand(name: Strings.tatCaChiNhanh);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeFlatButton.filter(
      child: Row(children: [
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: KayleeText.normalWhite16W400(
            selectedBrand.name ?? '',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )),
        Image.asset(
          Images.ic_triangle_down,
          color: Colors.white,
          width: Dimens.px16,
          height: Dimens.px16,
        )
      ]),
      background: ColorsRes.button,
      onPress: showPicker,
    );
  }

  void showPicker() {
    showPickerPopup(
        context: context,
        onDone: () {
          if (currentValue != null) {
            setState(() {
              selectedBrand = currentValue!;
            });
            widget.onChanged?.call(selectedBrand);
          }
        },
        onDismiss: () {
          currentValue = null;
        },
        builder: (context) {
          return _BrandPickerView.newInstance(
            intiValue: selectedBrand,
            onSelectedItemChanged: (value) {
              currentValue = value;
            },
          );
        });
  }
}

class _BrandPickerView extends StatefulWidget {
  static Widget newInstance(
          {required ValueChanged<Brand> onSelectedItemChanged,
          required Brand intiValue}) =>
      BlocProvider(
          create: (context) => _BrandSelectionBloc(
              brandService: context.network.provideBrandService()),
          child: _BrandPickerView._(
            intiValue: intiValue,
            onSelectedItemChanged: onSelectedItemChanged,
          ));
  final ValueChanged<Brand> onSelectedItemChanged;
  final Brand intiValue;

  _BrandPickerView._({
    required this.onSelectedItemChanged,
    required this.intiValue,
  });

  @override
  _BrandPickerViewState createState() => _BrandPickerViewState();
}

class _BrandPickerViewState extends BaseState<_BrandPickerView> {
  _BrandSelectionBloc get _bloc => context.bloc<_BrandSelectionBloc>()!;

  FixedExtentScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    _bloc.load();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_BrandSelectionBloc, SingleModel<List<Brand>>>(
      builder: (context, state) {
        if (state.loading) return Align(child: KayleeLoadingIndicator());
        scrollController = FixedExtentScrollController(
            initialItem:
            state.item?.indexWhere((e) => e.id == widget.intiValue.id) ??
                    0);
        return CupertinoPicker.builder(
          scrollController: scrollController,
          itemExtent: Dimens.px35,
          onSelectedItemChanged: (index) {
            widget.onSelectedItemChanged.call(state.item!.elementAt(index));
          },
          itemBuilder: (context, index) {
            final item = state.item!.elementAt(index);
            return Container(
              child: Text(item.name ?? '',
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    color: Color(0xff000000),
                    fontSize: 23.5,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.3799999952316284,
                  )),
            );
          },
          childCount: state.item?.length ?? 0,
        );
      },
    );
  }
}

class _BrandSelectionBloc extends Cubit<SingleModel<List<Brand>>> {
  final BrandService brandService;

  _BrandSelectionBloc({required this.brandService}) : super(SingleModel());

  void load() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: brandService.getAllBrands(),
      onSuccess: ({message, result}) {
        (result as List<Brand>).insert(0, Brand(name: Strings.tatCaChiNhanh));

        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }
}
