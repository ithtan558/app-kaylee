import 'package:kaylee/models/models.dart';

abstract class KayleeFilterInterface<T extends Filter> {
  void loadFilter();

  void resetFilter();

  bool get isEmptyFilter;

  T? getFilter();

  T updateFilter();
}
