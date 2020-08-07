import 'package:kaylee/models/models.dart';

abstract class KayleeFilterInterface<T extends Filter> {
  void loadFilter();

  void resetFilter();

  bool get isEmptyFilter;

  bool get loadFilterWhen;

  T getFilter();

  T updateFilter();
}
