// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerResponse _$ServerResponseFromJson(Map<String, dynamic> json) =>
    ServerResponse(
      session: json['session'] as bool?,
      action: json['action'] as bool?,
      result: json['result'],
      title: json['title'] as String?,
      message: json['message'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$ServerResponseToJson(ServerResponse instance) =>
    <String, dynamic>{
      'session': instance.session,
      'action': instance.action,
      'result': instance.result,
      'title': instance.title,
      'message': instance.message,
      'code': instance.code,
    };
