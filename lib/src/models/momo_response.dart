import 'package:json_annotation/json_annotation.dart';

part 'momo_response.g.dart';

@JsonSerializable()
class MoMoResponse {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'meta')
  final Meta meta;

  MoMoResponse({this.status, this.message, this.meta});

  factory MoMoResponse.fromJson(Map<String, dynamic> json) =>
      _$MoMoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoMoResponseToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'authorization')
  final Authorization authorization;

  Meta({this.authorization});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Authorization {
  @JsonKey(name: 'redirect')
  final String redirect;
  @JsonKey(name: 'mode')
  final String mode;

  Authorization({this.redirect, this.mode});

  factory Authorization.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationToJson(this);
}
