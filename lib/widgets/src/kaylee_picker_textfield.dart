import 'dart:math';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
    Key key,
    this.hint,
    this.error,
    this.title,
    this.controller,
  }) : super(key: key);

  @override
  _KayleePickerTextFieldState<T> createState() =>
      _KayleePickerTextFieldState<T>();
}

class _KayleePickerTextFieldState<T> extends BaseState<KayleePickerTextField> {
  final _tfController = TextEditingController();
  bool focused = false;
  T currentValue;
  KayleePickerTextFieldModel pickerTFModel;

  @override
  void initState() {
    widget?.controller?._view = this;
    try {
      pickerTFModel = context.repository<KayleePickerTextFieldModel>();
    } catch (e) {
      print('[TUNG] ===> chưa provide KayleePickerTextFieldModel');
    }
    updateValue();
    super.initState();
  }

  @override
  void didUpdateWidget(KayleePickerTextField oldWidget) {
    updateValue();
    super.didUpdateWidget(oldWidget);
  }

  ///set text để hiện thị trong [KayleePickerTextField]
  ///
  void updateValue() {
    _tfController.text = _getTitle(widget.controller?.value);
    pickerTFModel?.update(value: widget.controller?.value);
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
                  if (pickerTFModel?.city?.id.isNotNull) {
                    showPicker();
                  } else {
                    showAlert(content: Strings.xinVuiLongChonTinh);
                  }
                } else if (T == Ward) {
                  if (pickerTFModel?.district?.id.isNotNull) {
                    showPicker();
                  } else {
                    showAlert(content: Strings.xinVuiLongChonQuan);
                  }
                } else if (T == StartTime) {
                  showPicker();
                } else if (T == EndTime) {
                  showPicker();
                } else if (T == ProdCate) {
                  showPicker();
                } else if (T == ServiceCate) {
                  showPicker();
                } else if (T == ServiceDuration) {
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
          } else if (T == ServiceDuration) {
            if (widget.controller?.value == null || currentValue != null) {
              widget.controller?.value = currentValue;
            }
          } else {
            widget.controller?.value = currentValue;
          }
        },
        onDismiss: () {
          currentValue = null;
          setState(() {
            updateValue();
            focused = false;
          });
        },
        builder: (context) {
          return RepositoryProvider.value(
            value: pickerTFModel,
            child: T == ServiceDuration
                ? _HourPickerView(
                    intiValue: widget.controller?.value,
                    onSelectedItemChanged: (value) {
                      currentValue = value as T;
                    },
                  )
                : T == StartTime || T == EndTime
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
        });
  }
}

String _getTitle(dynamic item) {
  if (item is City ||
      item is District ||
      item is Ward ||
      item is ProdCate ||
      item is ServiceCate) {
    return item.name;
  } else if (item is StartTime || item is EndTime) {
    return item.formattedTime;
  } else if (item is ServiceDuration) {
    final hour = item.duration.isNotNull && item.duration.inHours > 0
        ? item.duration.inHours
        : 0;
    final minutes = item.duration.isNotNull && item.duration.inMinutes > 0
        ? item.duration.inMinutes - hour * Duration.minutesPerHour
        : 0;
    return '${hour > 0 ? '$hour giờ ' : ''}${minutes > 0 ? '$minutes phút' : ''}';
  }
  return '';
}

class _HourPickerView extends StatefulWidget {
  final ValueChanged<ServiceDuration> onSelectedItemChanged;
  final ServiceDuration intiValue;

  _HourPickerView({this.onSelectedItemChanged, this.intiValue});

  @override
  _HourPickerViewState createState() => _HourPickerViewState();
}

class _HourPickerViewState extends BaseState<_HourPickerView> {
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: Locale('vi'),
      delegates: [
        KayleeLocalizationDelegate(),
      ],
      child: CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hm,
        initialTimerDuration: widget.intiValue?.duration,
        onTimerDurationChanged: (Duration value) {
          widget.intiValue?.duration = value;
          widget.onSelectedItemChanged?.call(widget.intiValue);
        },
      ),
    );
  }
}

class KayleeLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'vi';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture(KayleeLocalizations());

  @override
  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) => false;
}

class KayleeLocalizations extends CupertinoLocalizations {
  @override
  // TODO: implement alertDialogLabel
  String get alertDialogLabel => throw UnimplementedError();

  @override
  // TODO: implement anteMeridiemAbbreviation
  String get anteMeridiemAbbreviation => throw UnimplementedError();

  @override
  // TODO: implement copyButtonLabel
  String get copyButtonLabel => throw UnimplementedError();

  @override
  // TODO: implement cutButtonLabel
  String get cutButtonLabel => throw UnimplementedError();

  @override
  // TODO: implement datePickerDateOrder
  DatePickerDateOrder get datePickerDateOrder => throw UnimplementedError();

  @override
  // TODO: implement datePickerDateTimeOrder
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      throw UnimplementedError();

  @override
  String datePickerDayOfMonth(int dayIndex) {
    // TODO: implement datePickerDayOfMonth
    throw UnimplementedError();
  }

  @override
  String datePickerHour(int hour) {
    // TODO: implement datePickerHour
    throw UnimplementedError();
  }

  @override
  String datePickerHourSemanticsLabel(int hour) {
    // TODO: implement datePickerHourSemanticsLabel
    throw UnimplementedError();
  }

  @override
  String datePickerMediumDate(DateTime date) {
    // TODO: implement datePickerMediumDate
    throw UnimplementedError();
  }

  @override
  String datePickerMinute(int minute) {
    // TODO: implement datePickerMinute
    throw UnimplementedError();
  }

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    throw UnimplementedError();
  }

  @override
  String datePickerMonth(int monthIndex) {
    // TODO: implement datePickerMonth
    throw UnimplementedError();
  }

  @override
  String datePickerYear(int yearIndex) {
    // TODO: implement datePickerYear
    throw UnimplementedError();
  }

  @override
  // TODO: implement pasteButtonLabel
  String get pasteButtonLabel => throw UnimplementedError();

  @override
  // TODO: implement postMeridiemAbbreviation
  String get postMeridiemAbbreviation => throw UnimplementedError();

  @override
  // TODO: implement selectAllButtonLabel
  String get selectAllButtonLabel => throw UnimplementedError();

  @override
  String timerPickerHour(int hour) {
    // TODO: implement timerPickerHour
    throw UnimplementedError();
  }

  @override
  String timerPickerHourLabel(int hour) => 'giờ';

  @override
  String timerPickerMinute(int minute) {
    // TODO: implement timerPickerMinute
    throw UnimplementedError();
  }

  @override
  String timerPickerMinuteLabel(int minute) => 'phút';

  @override
  String timerPickerSecond(int second) {
    // TODO: implement timerPickerSecond
    throw UnimplementedError();
  }

  @override
  String timerPickerSecondLabel(int second) {
    // TODO: implement timerPickerSecondLabel
    throw UnimplementedError();
  }

  @override
  String get todayLabel => throw UnimplementedError();
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
  KayleePickerTextFieldModel parentBloc;
  FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    try {
      parentBloc = context.repository<KayleePickerTextFieldModel>();
    } catch (e, s) {
      print('[TUNG] ===> $s');
    }

    bloc = _PickerViewBloc(
        commonService: context.network.provideCommonService(),
        productService: context.network.provideProductService(),
        servService: context.network.provideServService());
    if (T == City) {
      bloc.loadCity();
    } else if (T == District) {
      bloc.loadDistrict(parentBloc?.city?.id);
    } else if (T == Ward) {
      bloc.loadWard(parentBloc?.district?.id);
    } else if (T == ProdCate) {
      bloc.loadProCate();
    } else if (T == ServiceCate) {
      bloc.loadServiceCate();
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
    return BlocBuilder<_PickerViewBloc<T>, SingleModel<List<T>>>(
      cubit: bloc,
      builder: (context, state) {
        if (state.loading)
          return Align(
            child: CupertinoActivityIndicator(
              radius: Dimens.px16,
            ),
          );
        scrollController = FixedExtentScrollController(
            initialItem: state.item?.indexWhere(
                    (e) => getIndex(e) == getIndex(widget.intiValue)) ??
                0);
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
    if (item is City ||
        item is District ||
        item is Ward ||
        item is ProdCate ||
        item is ServiceCate) {
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
  ProductService productService;
  ServService servService;

  _PickerViewBloc({this.commonService, this.productService, this.servService})
      : super(SingleModel());

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

  void loadProCate() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: productService.getCategories(),
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

  void loadServiceCate() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: servService.getCategories(),
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

class KayleePickerTextFieldModel {
  City city;
  District district;
  StartTime startTime;
  EndTime endTime;
  ProdCate prodCate;
  ServiceCate serviceCate;

  KayleePickerTextFieldModel.copy(KayleePickerTextFieldModel old) {
    this
      ..city = old?.city
      ..district = old?.district
      ..startTime = old?.startTime
      ..endTime = old?.endTime
      ..prodCate = old?.prodCate
      ..serviceCate = old?.serviceCate;
  }

  KayleePickerTextFieldModel({this.city,
    this.district,
    this.startTime,
    this.endTime,
    this.prodCate,
    this.serviceCate});

  void update({dynamic value}) {
    if (value is City) {
      this.city = value;
    } else if (value is District) {
      this.district = value;
    } else if (value is StartTime) {
      this.startTime = value;
    } else if (value is EndTime) {
      this.endTime = value;
    } else if (value is ProdCate) {
      this.prodCate = value;
    } else if (value is ServiceCate) {
      this.serviceCate = value;
    }
  }
}
