import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class KayleePickerTextField<T> extends StatefulWidget {
  final String title;
  final String error;
  final String hint;

  KayleePickerTextField({
    this.hint,
    this.error,
    this.title,
  });

  @override
  _KayleePickerTextFieldState<T> createState() =>
      _KayleePickerTextFieldState<T>();
}

class _KayleePickerTextFieldState<T> extends BaseState<KayleePickerTextField> {
  final _tfController = TextEditingController();
  bool focused = false;

  @override
  void dispose() {
    _tfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeTextField(
      title: widget.title,
      textInput: ErrorText(
        child: TextFieldBorderWrapper(
            GestureDetector(
              onTap: () {
                if (T == District && context.repository<City>().id.isNotNull ||
                    T == Ward && context.repository<Ward>().id.isNotNull ||
                    T == City) {
                  setState(() {
                    focused = true;
                  });
                  showPickerPopup(
                      context: context,
                      builder: (context) {
                        return _PickerView<T>();
                      }).then((value) {
                    setState(() {
                      focused = false;
                    });
                  });
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _tfController,
                        enabled: false,
                        decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: widget.hint,
                            contentPadding: const EdgeInsets.only(
                              bottom: Dimens.px4,
                              left: Dimens.px16,
                            ),
                            hintStyle: TextStyles.hint16W400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Dimens.px16,
                      ),
                      child: Image.asset(
                        Images.ic_down,
                        width: Dimens.px16,
                        height: Dimens.px16,
                      ),
                    )
                  ],
                ),
              ),
            ),
            focused: focused,
            showFocusBorder: !widget.error.isNullOrEmpty),
        error: widget.error,
      ),
    );
  }
}

class _PickerView<T> extends StatefulWidget {
  final City city;
  final District district;

  _PickerView({this.city, this.district});

  @override
  _PickerViewState<T> createState() => _PickerViewState<T>();
}

class _PickerViewState<T> extends BaseState<_PickerView> {
  _PickerViewBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc =
        _PickerViewBloc(commonService: context.network.provideCommonService());
    if (T == City) {
      bloc.loadCity();
    } else if (T == District) {
      if (widget.city.isNotNull) {
        bloc.loadDistrict(widget.city.id);
      }
    } else if (T == Ward) {
      if (widget.district.isNotNull) {
        bloc.loadWard(widget.district.id);
      }
    }
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubitBuilder<_PickerViewBloc<T>, SingleModel<List<T>>>(
      builder: (context, state) {
        if (state.loading)
          return Align(
            child: CupertinoActivityIndicator(
              radius: Dimens.px16,
            ),
          );
        return CupertinoPicker.builder(
          itemExtent: Dimens.px36,
          onSelectedItemChanged: (value) {},
          itemBuilder: (context, index) {
            return Container();
          },
          childCount: state.item?.length ?? 0,
        );
      },
    );
  }
}

class PickInputController<T> {
  _KayleePickerTextFieldState _view;
  T _value;
//  T value = _view.PickInputController();
}

class _PickerViewBloc<T> extends Cubit<SingleModel<List<T>>> {
  CommonService commonService;

  _PickerViewBloc({this.commonService}) : super(SingleModel());

  void loadCity() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getCity(),
      onSuccess: ({message, result}) {
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

  void loadDistrict(int city) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getDistrict(city),
      onSuccess: ({message, result}) {
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

  void loadWard(int district) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getWard(district),
      onSuccess: ({message, result}) {
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
