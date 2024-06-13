// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    UploadResponse(
      status: json['status'] as String?,
      uploadProgress: json['uploadProgress'] as String?,
      message: json['message'] as String?,
      boolFinalize: json['boolFinalize'] as bool?,
      boolInitial: json['boolInitial'] as bool?,
      boolSuccess: json['boolSuccess'] as bool?,
    );

Map<String, dynamic> _$UploadResponseToJson(UploadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'uploadProgress': instance.uploadProgress,
      'message': instance.message,
      'boolFinalize': instance.boolFinalize,
      'boolInitial': instance.boolInitial,
      'boolSuccess': instance.boolSuccess,
    };
