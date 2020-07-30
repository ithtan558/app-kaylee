import 'package:anth_package/anth_package.dart';

class BrandSelectTfBloc extends Cubit {
  BrandSelectTfBloc() : super(UpdateSelectBrandState());

  void update() => emit(UpdateSelectBrandState());
}

class UpdateSelectBrandState {}
