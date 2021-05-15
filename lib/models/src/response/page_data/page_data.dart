import 'package:anth_package/anth_package.dart';

part 'page_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PageData<T> {
  factory PageData.fromJson(Map<String, dynamic> json,
          T Function(Map<String, dynamic> json) fromJson) =>
      _$PageDataFromJson<T>(json);

  Map<String, dynamic> toJson() => _$PageDataToJson<T>(this);

  PageData({
    this.page,
    this.limit,
    this.total,
    this.pages,
    this.items,
  });

  int? page;
  int? limit;
  int? total;
  int? pages;
  @Converter()
  List<T>? items;
}
