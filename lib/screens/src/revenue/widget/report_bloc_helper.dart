import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';

mixin ReportBlocHelper {
  ReportService reportService;
  Brand _brand;
  DateTime _startDate;
  DateTime _endDate;

  String get startDateInString =>
      _startDate?.toFormatString(pattern: dateFormat);

  String get endDateInString => _endDate?.toFormatString(pattern: dateFormat);

  Brand get brand => _brand;

  @mustCallSuper
  void loadData({Brand brand, DateTime startDate, DateTime endDate}) {
    if (brand.isNotNull) this._brand = brand;
    if (startDate.isNotNull) this._startDate = startDate;
    if (endDate.isNotNull) this._endDate = endDate;
  }
}
