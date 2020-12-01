import 'package:core_plugin/core_plugin.dart';

part 'product_image.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProductImage {
  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageToJson(this);

  ProductImage({
    this.type,
    this.value,
  });

  final ProductImageType type;
  final String value;

  ProductImage copyWith({
    int type,
    String value,
  }) =>
      ProductImage(
        type: type ?? this.type,
        value: value ?? this.value,
      );
}

enum ProductImageType {
  @JsonValue(1)
  image,
  @JsonValue(2)
  video,
}
