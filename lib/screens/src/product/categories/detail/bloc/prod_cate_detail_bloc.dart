import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ProdCateDetailBloc extends Cubit<SingleModel<ProdCate>>
    implements CRUDInterface {
  final ProductService productService;

  ProdCateDetailBloc({
    this.productService,
    ProdCate prodCate,
  }) : super(SingleModel(item: prodCate));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: productService.newProdCate(
        name: state.item?.name,
        code: state.item?.code,
        sequence: state.item.sequence,
      ),
      onSuccess: ({message, result}) {
        emit(NewProductCateModel.copy(state
          ..loading = false
          ..message = message));
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
      request: productService.deleteProdCate(cateId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(DeleteProductCateModel.copy(
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
      request: productService.getProdCateDetail(cateId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(DetailProductCateModel.copy(state
          ..loading = false
          ..item = result));
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
      request: productService.updateProdCate(
        name: state.item?.name,
        code: state.item?.code,
        sequence: state.item?.sequence,
        id: state.item?.id,
        cateId: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateProductCateModel.copy(state
          ..loading = false
          ..message = message));
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

class UpdateProductCateModel extends SingleModel<ProdCate> {
  UpdateProductCateModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class DeleteProductCateModel extends SingleModel<ProdCate> {
  DeleteProductCateModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class NewProductCateModel extends SingleModel<ProdCate> {
  NewProductCateModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class DetailProductCateModel extends SingleModel<ProdCate> {
  DetailProductCateModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item;
  }
}
