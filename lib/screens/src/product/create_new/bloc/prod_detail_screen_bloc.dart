import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ProdDetailScreenBloc extends Cubit<SingleModel<Product>>
    implements CRUDInterface {
  final ProductService prodService;

  ProdDetailScreenBloc({this.prodService, Product product})
      : super(SingleModel(item: product));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: prodService.newProduct(
          name: state.item?.name,
          brandIds: state.item?.brandIds,
          price: state.item?.price,
          categoryId: state.item?.category?.id,
          description: state.item?.description,
          image: state.item?.imageFile),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void delete() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: prodService.deleteProduct(prodId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void get() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: prodService.getProduct(proId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void update() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: prodService.updateProduct(
        name: state.item?.name,
        brandIds: state.item?.brandIds,
        price: state.item?.price,
        categoryId: state.item?.category?.id,
        description: state.item?.description,
        image: state.item?.imageFile,
        prodId: state.item?.id,
        id: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }
}
