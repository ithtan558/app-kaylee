import 'package:core_plugin/core_plugin.dart';

part 'banner.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Banner {
  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

  Map<String, dynamic> toJson() => _$BannerToJson(this);

  Banner({
    this.id,
    this.title,
    this.image,
    this.description,
    this.url,
    this.type,
  });

  final int? id;
  final String? title;
  final String? image;
  final String? description;
  final String? url;
  final int? type;

  Banner copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    String? url,
    int? type,
  }) =>
      Banner(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        description: description ?? this.description,
        url: url ?? this.url,
        type: type ?? this.type,
      );
}
