import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Content {
  static const POLICY_HASHTAG = 'dieu-kien-va-dieu-khoan';
  static const CONTACT_US_HASHTAG = 'lien-he-voi-chung-toi';
  static const USER_GUIDE_HASHTAG = 'huong-dan-su-dung';
  static const EXPIRATION_HASHTAG = 'gia-han-su-dung';

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  Content({
    this.id,
    this.name,
    this.code,
    this.description,
    this.content,
    this.image,
  });

  int id;
  String name;
  String code;
  String description;
  String content;
  String image;
}
