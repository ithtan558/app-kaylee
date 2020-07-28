import 'dart:math';

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
  final PickInputController<T> controller;

  KayleePickerTextField({
    this.hint,
    this.error,
    this.title,
    this.controller,
  });

  @override
  _KayleePickerTextFieldState<T> createState() =>
      _KayleePickerTextFieldState<T>();
}

class _KayleePickerTextFieldState<T> extends BaseState<KayleePickerTextField> {
  final _tfController = TextEditingController();
  bool focused = false;
  T currentValue;
  KayleePickerTextFieldBloc bloc;

  @override
  void initState() {
    widget?.controller?._view = this;
    try {
      bloc = context.cubit<KayleePickerTextFieldBloc>();
    } catch (e) {
      print('[TUNG] ===> chưa provide KayleePickerTextFieldBloc');
    }
    _tfController.text = _getTitle(widget.controller?.value);
    bloc?.update(value: widget.controller?.value);
    super.initState();
  }

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
                if (T == City) {
                  showPicker();
                } else if (T == District) {
                  if (bloc?.state?.city?.id.isNotNull) {
                    showPicker();
                  } else {
                    showAlert(content: Strings.xinVuiLongChonTinh);
                  }
                } else if (T == Ward) {
                  if (bloc?.state?.district?.id.isNotNull) {
                    showPicker();
                  } else {
                    showAlert(content: Strings.xinVuiLongChonQuan);
                  }
                } else if (T == StartTime) {
                  showPicker();
                } else if (T == EndTime) {
                  showPicker();
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
                      child: Transform.rotate(
                        angle: focused ? pi : 0,
                        child: Image.asset(
                          Images.ic_down,
                          width: Dimens.px16,
                          height: Dimens.px16,
                        ),
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

  void showAlert({String content}) {
    showKayleeAlertDialog(
        context: context,
        view: KayleeAlertDialogView(
          content: content,
          actions: [
            KayleeAlertDialogAction.dongY(
              onPressed: () {
                popScreen();
              },
            )
          ],
        ));
  }

  void showPicker() {
    setState(() {
      focused = true;
    });
    showPickerPopup(
        context: context,
        onDone: () {
          if (T == EndTime || T == StartTime) {
            if (widget.controller?.value == null || currentValue != null) {
              widget.controller?.value = currentValue;
            }
          } else {
            widget.controller?.value = currentValue;
          }
        },
        onDismiss: () {
          currentValue = null;
        },
        builder: (context) {
          return CubitProvider.value(
            value: bloc,
            child: T == StartTime || T == EndTime
                ? _TimePickerView<T>(
                    intiValue: widget.controller?.value,
                    onSelectedItemChanged: (value) {
                      currentValue = value;
                    },
                  )
                : _PickerView<T>(
                    intiValue: widget.controller?.value,
                    onSelectedItemChanged: (value) {
                      currentValue = value;
                    },
                  ),
          );
        }).then((value) {
      setState(() {
        _tfController.text = _getTitle(widget?.controller?.value);
        bloc?.update(value: widget?.controller?.value);
        focused = false;
      });
    });
  }
}

String _getTitle(dynamic item) {
  if (item is City || item is District || item is Ward) {
    return item.name;
  } else if (item is StartTime || item is EndTime) {
    return item.time;
  }
  return '';
}

class _TimePickerView<T> extends StatefulWidget {
  final ValueChanged onSelectedItemChanged;
  final T intiValue;

  _TimePickerView({this.onSelectedItemChanged, this.intiValue});

  @override
  _TimePickerViewState<T> createState() => _TimePickerViewState<T>();
}

class _TimePickerViewState<T> extends BaseState<_TimePickerView> {
  DateTime initDateTime;

  @override
  void initState() {
    super.initState();
    try {} catch (e, s) {
      print('[TUNG] ===> $s');
    }
    if (widget.intiValue is StartTime || widget.intiValue is EndTime) {
      initDateTime = widget.intiValue.datetime;
    } else {
      initDateTime = DateTime(0);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      initialDateTime: initDateTime,
      onDateTimeChanged: (DateTime value) {
        widget.onSelectedItemChanged?.call(T == StartTime
            ? StartTime(time: DateFormat('HH:mm').format(value))
            : EndTime(time: DateFormat('HH:mm').format(value)));
      },
    );
  }
}

class _PickerView<T> extends StatefulWidget {
  final ValueChanged onSelectedItemChanged;
  final T intiValue;

  _PickerView({this.onSelectedItemChanged, this.intiValue});

  @override
  _PickerViewState<T> createState() => _PickerViewState<T>();
}

class _PickerViewState<T> extends BaseState<_PickerView> {
  _PickerViewBloc<T> bloc;
  KayleePickerTextFieldBloc parentBloc;
  FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    try {
      parentBloc = context.cubit<KayleePickerTextFieldBloc>();
    } catch (e, s) {
      print('[TUNG] ===> $s');
    }

    bloc =
        _PickerViewBloc(commonService: context.network.provideCommonService());
    if (T == City) {
      bloc.loadCity();
    } else if (T == District) {
      bloc.loadDistrict(parentBloc?.state?.city?.id);
    } else if (T == Ward) {
      bloc.loadWard(parentBloc?.state?.district?.id);
    }
  }

  @override
  void dispose() {
    bloc.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubitBuilder<_PickerViewBloc<T>, SingleModel<List<T>>>(
      cubit: bloc,
      builder: (context, state) {
        if (state.loading)
          return Align(
            child: CupertinoActivityIndicator(
              radius: Dimens.px16,
            ),
          );
        scrollController = FixedExtentScrollController(
            initialItem: state.item
                .indexWhere((e) => getIndex(e) == getIndex(widget.intiValue)));
        return CupertinoPicker.builder(
          scrollController: scrollController,
          itemExtent: Dimens.px35,
          onSelectedItemChanged: (index) {
            widget.onSelectedItemChanged?.call(state.item.elementAt(index));
          },
          itemBuilder: (context, index) {
            final item = state.item.elementAt(index);
            return Container(
              child: Text(_getTitle(item),
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

  int getIndex(dynamic item) {
    if (item is City || item is District || item is Ward) {
      return item.id;
    }
    return 0;
  }
}

class PickInputController<T> {
  _KayleePickerTextFieldState _view;
  T value;

  PickInputController({this.value});
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

class KayleePickerTextFieldBloc extends Cubit<KayleePickerTextFieldState> {
  KayleePickerTextFieldBloc() : super(KayleePickerTextFieldState());

  void update({dynamic value}) {
    if (value is City) {
      emit(KayleePickerTextFieldState.copy(state..city = value));
    } else if (value is District) {
      emit(KayleePickerTextFieldState.copy(state..district = value));
    } else if (value is StartTime) {
      emit(KayleePickerTextFieldState.copy(state..startTime = value));
    } else if (value is EndTime) {
      emit(KayleePickerTextFieldState.copy(state..endTime = value));
    }
  }
}

class KayleePickerTextFieldState {
  City city;
  District district;
  StartTime startTime;
  EndTime endTime;

  KayleePickerTextFieldState(
      {this.city, this.district, this.startTime, this.endTime});

  KayleePickerTextFieldState.copy(KayleePickerTextFieldState old) {
    this
      ..city = old?.city
      ..district = old?.district
      ..startTime = old?.startTime
      ..endTime = old?.endTime;
  }
}
