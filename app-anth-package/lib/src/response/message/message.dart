import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  String? title;
  String? content;

  Message({this.title, this.content});

  factory Message.copy(Message old) =>
      Message(title: old.title, content: old.content);
}
