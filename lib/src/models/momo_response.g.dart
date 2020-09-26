// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'momo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoMoResponse _$MoMoResponseFromJson(Map<String, dynamic> json) {
  return MoMoResponse(
    status: json['status'] as String,
    message: json['message'] as String,
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MoMoResponseToJson(MoMoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'meta': instance.meta,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return Meta(
    authorization: json['authorization'] == null
        ? null
        : Authorization.fromJson(json['authorization'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'authorization': instance.authorization,
    };

Authorization _$AuthorizationFromJson(Map<String, dynamic> json) {
  return Authorization(
    redirect: json['redirect'] as String,
    mode: json['mode'] as String,
  );
}

Map<String, dynamic> _$AuthorizationToJson(Authorization instance) =>
    <String, dynamic>{
      'redirect': instance.redirect,
      'mode': instance.mode,
    };
