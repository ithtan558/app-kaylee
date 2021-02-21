// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ProductService implements ProductService {
  _ProductService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<PageData<Product>>> getProducts(
      {supplierId, keyword, sort, categoryId, page, limit}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'supplier_id': supplierId,
      r'keyword': keyword,
      r'sort': sort,
      r'category_id': categoryId,
      r'page': page,
      r'limit': limit
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('product',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<PageData<Product>>.fromJson(
      _result.data,
      (json) => PageData<Product>.fromJson(
        json,
        (json) => Product.fromJson(json),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<List<ProdCate>>> getCategories({supplierId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'supplier_id': supplierId};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'product-category/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<List<ProdCate>>.fromJson(
        _result.data,
        (json) => (json as List<dynamic>)
            .map<ProdCate>((i) => ProdCate.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }

  @override
  Future<ResponseModel<PageData<ProdCate>>> getCategoryList(
      {page, limit, sort}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'sort': sort
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('product-category',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<PageData<ProdCate>>.fromJson(
      _result.data,
      (json) => PageData<ProdCate>.fromJson(
        json,
        (json) => ProdCate.fromJson(json),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<ProdCate>> getProdCateDetail({cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'product-category/$cateId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<ProdCate>.fromJson(
      _result.data,
      (json) => ProdCate.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newProdCate({name, code, sequence}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (code != null) {
      _data.fields.add(MapEntry('code', code));
    }
    if (sequence != null) {
      _data.fields.add(MapEntry('sequence', sequence.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>('product-category',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(
      _result.data,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateProdCate(
      {name, code, sequence, id, cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (code != null) {
      _data.fields.add(MapEntry('code', code));
    }
    if (sequence != null) {
      _data.fields.add(MapEntry('sequence', sequence.toString()));
    }
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>(
        'product-category/$cateId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(
      _result.data,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteProdCate({cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'product-category/delete/$cateId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(
      _result.data,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<Product>> getProduct({proId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('product/$proId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Product>.fromJson(
      _result.data,
      (json) => Product.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newProduct(
      {name, description, brandIds, price, image, categoryId, code}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (description != null) {
      _data.fields.add(MapEntry('description', description));
    }
    if (brandIds != null) {
      _data.fields.add(MapEntry('brand_ids', brandIds));
    }
    if (price != null) {
      _data.fields.add(MapEntry('price', price.toString()));
    }
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    if (categoryId != null) {
      _data.fields.add(MapEntry('category_id', categoryId.toString()));
    }
    if (code != null) {
      _data.fields.add(MapEntry('code', code));
    }
    final _result = await _dio.request<Map<String, dynamic>>('product',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(
      _result.data,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateProduct(
      {name,
      description,
      brandIds,
      price,
      image,
      categoryId,
      code,
      id,
      prodId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (description != null) {
      _data.fields.add(MapEntry('description', description));
    }
    if (brandIds != null) {
      _data.fields.add(MapEntry('brand_ids', brandIds));
    }
    if (price != null) {
      _data.fields.add(MapEntry('price', price.toString()));
    }
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    if (categoryId != null) {
      _data.fields.add(MapEntry('category_id', categoryId.toString()));
    }
    if (code != null) {
      _data.fields.add(MapEntry('code', code));
    }
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>('product/$prodId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(
      _result.data,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteProduct({prodId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'product/delete/$prodId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(
      _result.data,
      (json) => json as dynamic,
    );
    return value;
  }
}
