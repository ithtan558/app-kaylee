import 'package:cubit/cubit.dart';

class ScrollOffsetBloc extends Cubit<double> {
  ScrollOffsetBloc() : super(0);

  void addOffset(double offset) => emit(offset);
}
