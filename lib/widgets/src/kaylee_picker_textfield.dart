import 'dart:math';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

const types = <Type>[
  City,
  District,
  Ward,
  ProdCate,
  ServiceCate,
  Brand,
  CustomerType,
  Role,
  Employee,
  ReservationStatus
];

abstract class KayleePickerTextFieldView {
  void clear();
}

class KayleePickerTextField<T> extends StatefulWidget {
  final String title;
  final String error;
  final String hint;
  final PickInputController<T> controller;

  ///nếu [useForFilter] == true (khi [KayleePickerTextField] đc gắn ở [FilterScreen]) => hiện item 'Tất cả'
  final bool useForFilter;

  final ValueSetter<dynamic> onSelect;

  KayleePickerTextField({
    Key key,
    this.hint,
    this.error,
    this.title,
    this.controller,
    this.useForFilter,
    this.onSelect,
  }) : super(key: key);

  @override
  _KayleePickerTextFieldState<T> createState() =>
      _KayleePickerTextFieldState<T>();
}

class _KayleePickerTextFieldState<T> extends BaseState<KayleePickerTextField>
    implements KayleePickerTextFieldView {
  final _tfController = TextEditingController();
  bool focused = false;
  T currentValue;
  KayleePickerTextFieldModel pickerTFModel;

  @override
  void initState() {
    super.initState();
    widget?.controller?._view = this;
    try {
      pickerTFModel = context.repository<KayleePickerTextFieldModel>();
    } catch (e) {
      // print('[TUNG] ===> chưa provide KayleePickerTextFieldModel');
    }
    updateValue();
  }

  @override
  void didUpdateWidget(KayleePickerTextField oldWidget) {
    updateValue();
    super.didUpdateWidget(oldWidget);
  }

  ///set text để hiện thị trong [KayleePickerTextField]
  ///
  void updateValue() {
    currentValue = widget.controller?.value;
    _tfController.text = _getTitle<T>(widget.controller?.value);
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
                } else if (T == Employee) {
                  if (pickerTFModel?.brand?.id.isNotNull) {
                    showPicker();
                  } else {
                    showAlert(content: Strings.batBuocChonChiNhanh);
                  }
                } else {
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
            isError: !widget.error.isNullOrEmpty),
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
          if (currentValue != null) {
            widget.controller?.value = currentValue;
            widget?.onSelect?.call(currentValue);
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
            child: T == DateTime
                ? _DatePickerView(
                    intiValue: widget.controller?.value,
                    maxDate: widget.controller is DatePickInputController
                        ? (widget.controller as DatePickInputController).maxDate
                        : null,
                    minDate: widget.controller is DatePickInputController
                        ? (widget.controller as DatePickInputController).minDate
                        : null,
                    onSelectedItemChanged: (value) {
                      currentValue = value as T;
                    },
                  )
                : T == Duration
                    ? _DurationPickerView(
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
                            useForFilter: widget.useForFilter,
                            onSelectedItemChanged: (value) {
                              currentValue = value;
                            },
                          ),
          );
        });
  }

  @override
  void clear() {
    widget.controller?.value = null;
    updateValue();
    setState(() {});
  }
}

String _getTitle<T>(dynamic item) {
  if (item != null && types.contains(T)) {
    if (item is ReservationStatus) {
      if (item == ReservationStatus.booked) return Strings.daDat;
      if (item == ReservationStatus.came) return Strings.daDen;
      if (item == ReservationStatus.canceled) return Strings.huy;
    }
    return item.name;
  } else if (item is StartTime || item is EndTime) {
    return item.formattedTime;
  } else if (item is Duration) {
    final hour = item.isNotNull && item.inHours > 0 ? item.inHours : 0;
    final minutes = item.isNotNull && item.inMinutes > 0
        ? item.inMinutes - hour * Duration.minutesPerHour
        : 0;
    return '${hour > 0 ? '$hour giờ ' : ''}${minutes > 0 ? '$minutes phút' : ''}';
  } else if (item is DateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(item);
  }
  return '';
}

class _DatePickerView extends StatefulWidget {
  final ValueChanged<DateTime> onSelectedItemChanged;
  final DateTime intiValue;
  final DateTime minDate;
  final DateTime maxDate;

  _DatePickerView(
      {this.onSelectedItemChanged, this.intiValue, this.minDate, this.maxDate});

  @override
  _DatePickerViewState createState() => _DatePickerViewState();
}

class _DatePickerViewState extends BaseState<_DatePickerView> {
  DateTime initDateTime;

  @override
  void initState() {
    super.initState();
    if (widget.intiValue.isNull) {
      initDateTime = DateTime.now();
      widget.onSelectedItemChanged?.call(initDateTime);
    } else {
      initDateTime = widget.intiValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      initialDateTime: initDateTime,
      minimumDate: widget.minDate?.toDate12AM(),
      maximumDate: widget.maxDate?.toDate12PM(),
      onDateTimeChanged: (DateTime value) {
        widget.onSelectedItemChanged?.call(value);
      },
    );
  }
}

class _DurationPickerView extends StatefulWidget {
  final ValueChanged<Duration> onSelectedItemChanged;
  final Duration intiValue;

  _DurationPickerView({
    this.onSelectedItemChanged,
    this.intiValue,
  });

  @override
  _DurationPickerViewState createState() => _DurationPickerViewState();
}

class _DurationPickerViewState extends BaseState<_DurationPickerView> {
  Duration initDuration;

  @override
  void initState() {
    super.initState();
    if (widget.intiValue.isNull) {
      initDuration = Duration.zero;
      widget.onSelectedItemChanged?.call(initDuration);
    } else {
      initDuration = widget.intiValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      initialTimerDuration: initDuration,
      onTimerDurationChanged: (Duration value) {
        widget.onSelectedItemChanged?.call(value);
      },
    );
  }
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
      widget.onSelectedItemChanged?.call(T == StartTime
          ? StartTime(time: DateFormat('HH:mm').format(initDateTime))
          : EndTime(time: DateFormat('HH:mm').format(initDateTime)));
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
  final bool useForFilter;

  _PickerView({this.onSelectedItemChanged, this.intiValue, this.useForFilter});

  @override
  _PickerViewState<T> createState() => _PickerViewState<T>();
}

class _PickerViewState<T> extends KayleeState<_PickerView> {
  _PickerViewBloc<T> bloc;
  KayleePickerTextFieldModel parentBloc;
  FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    try {
      parentBloc = context.repository<KayleePickerTextFieldModel>();
    } catch (e, _) {
      // print('[TUNG] ===> $s');
    }

    bloc = _PickerViewBloc(
      commonService: context.network.provideCommonService(),
      productService: context.network.provideProductService(),
      servService: context.network.provideServService(),
      brandService: context.network.provideBrandService(),
      customerService: context.network.provideCustomerService(),
      roleService: context.network.provideRoleService(),
      employeeService: context.network.provideEmployeeService(),
      useForFilter: widget.useForFilter,
    );
    loadData();
  }

  void loadData() {
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
    } else if (T == Brand) {
      bloc.loadBrands();
    } else if (T == CustomerType) {
      bloc.loadCustomerType();
    } else if (T == Role) {
      bloc.loadRole();
    } else if (T == Employee) {
      bloc.loadEmployees(parentBloc?.brand?.id);
    } else if (T == ReservationStatus) {
      bloc.loadReservationStatus();
    }
  }

  @override
  void onReloadWidget(Type widget, Bundle bundle) {
    loadData();
  }

  @override
  void dispose() {
    bloc.close();
    scrollController?.dispose();
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
              child: Text(_getTitle<T>(item),
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
    if (item != null && types.contains(T)) {
      if (item is ReservationStatus) return item.index;
      return item.id;
    }
    return 0;
  }
}

class DatePickInputController extends PickInputController<DateTime> {
  final DateTime minDate;
  final DateTime maxDate;

  DatePickInputController({DateTime value, this.minDate, this.maxDate})
      : super(value: value);
}

class PickInputController<T> {
  KayleePickerTextFieldView _view;
  T value;

  PickInputController({this.value});

  void clear() {
    _view?.clear();
  }
}

class _PickerViewBloc<T> extends Cubit<SingleModel<List<T>>> {
  final CommonService commonService;
  final ProductService productService;
  final ServService servService;
  final BrandService brandService;
  final CustomerService customerService;
  final RoleService roleService;
  final EmployeeService employeeService;
  final bool useForFilter;

  _PickerViewBloc({
    this.commonService,
    this.productService,
    this.servService,
    this.brandService,
    this.customerService,
    this.roleService,
    this.employeeService,
    this.useForFilter,
  }) : super(SingleModel());

  void loadCity() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getCity(),
      onSuccess: ({message, result}) {
        if (useForFilter ?? false) {
          (result as List<City>).insert(0, City(name: Strings.tatCa));
        }

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
        if (useForFilter ?? false) {
          (result as List<District>).insert(0, District(name: Strings.tatCa));
        }

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
        if (useForFilter ?? false) {
          (result as List<Ward>).insert(0, Ward(name: Strings.tatCa));
        }

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
        if (useForFilter ?? false) {
          (result as List<ProdCate>)
              .insert(0, ProdCate()..name = Strings.tatCa);
        }

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
        if (useForFilter ?? false) {
          (result as List<ServiceCate>)
              .insert(0, ServiceCate()..name = Strings.tatCa);
        }

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

  void loadBrands() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: brandService.getAllBrands(),
      onSuccess: ({message, result}) {
        if (useForFilter ?? false) {
          (result as List<Brand>).insert(0, Brand(name: Strings.tatCa));
        }

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

  void loadCustomerType() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: customerService.getCustomerType(),
      onSuccess: ({message, result}) {
        if (useForFilter ?? false) {
          (result as List<CustomerType>)
              .insert(0, CustomerType(name: Strings.tatCa));
        }
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

  void loadRole() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: roleService.getRoles(),
      onSuccess: ({message, result}) {
        if (useForFilter ?? false) {
          (result as List<Role>).insert(0, Role(id: -1, name: Strings.tatCa));
        }

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

  void loadEmployees(int brandId) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: employeeService.findEmployees(brandId: brandId),
      onSuccess: ({message, result}) {
        if (useForFilter ?? false) {
          (result as List<Employee>).insert(0, Employee(name: Strings.tatCa));
        }

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

  void loadReservationStatus() {
    emit(SingleModel.copy(state
      ..loading = false
      ..item = [
        ReservationStatus.booked,
        ReservationStatus.came,
        ReservationStatus.canceled,
      ] as List<T>
      ..code = null
      ..error = null));
  }
}

//dùng cho những field cần phải pick trước (ex: select tỉnh phải select city trước)
class KayleePickerTextFieldModel {
  City city;
  District district;
  StartTime startTime;
  EndTime endTime;
  ProdCate prodCate;
  ServiceCate serviceCate;
  Brand brand;
  CustomerType customerType;

  KayleePickerTextFieldModel.copy(KayleePickerTextFieldModel old) {
    this
      ..city = old?.city
      ..district = old?.district
      ..startTime = old?.startTime
      ..endTime = old?.endTime
      ..prodCate = old?.prodCate
      ..serviceCate = old?.serviceCate
      ..brand = old?.brand
      ..customerType = old?.customerType;
  }

  KayleePickerTextFieldModel({
    this.city,
    this.district,
    this.startTime,
    this.endTime,
    this.prodCate,
    this.serviceCate,
    this.brand,
    this.customerType,
  });

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
    } else if (value is Brand) {
      this.brand = value;
    } else if (value is CustomerType) {
      this.customerType = value;
    }
  }
}
