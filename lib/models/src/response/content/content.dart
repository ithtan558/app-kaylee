import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'content.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Content {
  static const policyHashtag = 'dieu-kien-va-dieu-khoan';
  static const contactUsHashtag = 'lien-he-voi-chung-toi';
  static const userGuideHashtag = 'huong-dan-su-dung';
  static const expirationHashtag = 'gia-han-su-dung';
  static const other = 1;
  static const knowledge = 2;
  static const hotEvent = 3;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  Content({
    this.id = -1,
    this.name = '',
    this.code = '',
    this.description = '',
    this.content = '',
    this.image = '',
    this.createdAt,
    this.slug = '',
    this.supplier,
    this.views = 0,
  });

  final int id;
  final String name;
  final String code;
  final String description;
  final String content;
  final String image;
  final DateTime? createdAt;
  final String slug;
  final Supplier? supplier;
  @JsonKey(name: 'number_view')
  final int views;
}
