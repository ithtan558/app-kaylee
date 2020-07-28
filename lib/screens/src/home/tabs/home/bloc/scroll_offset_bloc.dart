import 'package:anth_package/anth_package.dart';

class ScrollOffsetBloc extends Cubit<double> {
  ScrollOffsetBloc() : super(0);

  void addOffset(double offset) => emit(offset);
}
