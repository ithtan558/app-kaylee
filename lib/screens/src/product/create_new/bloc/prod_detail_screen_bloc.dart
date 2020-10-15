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
          code: state.item.code,
          name: state.item?.name,
          brandIds: state.item?.selectedBrandIds,
          price: state.item?.price,
          categoryId: state.item?.category?.id,
          description: state.item?.description,
          image: state.item?.imageFile),
      onSuccess: ({message, result}) {
        emit(NewProdDetailModel.copy(
          state
            ..loading = false
            ..message = message,
        ));
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
        emit(DeleteProdDetailModel.copy(
          state
            ..loading = false
            ..message = message,
        ));
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
        (result as Product).brands?.forEach((e) {
          e.selected = true;
        });
        emit(ProdDetailModel.copy(
          state
            ..loading = false
            ..item = result,
        ));
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
        code: state.item.code,
        name: state.item?.name,
        brandIds: state.item?.selectedBrandIds,
        price: state.item?.price,
        categoryId: state.item?.category?.id,
        description: state.item?.description,
        image: state.item?.imageFile,
        prodId: state.item?.id,
        id: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateProdDetailModel.copy(
          state
            ..loading = false
            ..message = message,
        ));
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

class ProdDetailModel extends SingleModel<Product> {
  ProdDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item;
  }
}

class DeleteProdDetailModel extends SingleModel<Product> {
  DeleteProdDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class UpdateProdDetailModel extends SingleModel<Product> {
  UpdateProdDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class NewProdDetailModel extends SingleModel<Product> {
  NewProdDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}
