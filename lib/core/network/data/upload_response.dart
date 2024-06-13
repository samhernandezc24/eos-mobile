import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_response.g.dart';

@JsonSerializable()
class UploadResponse extends Equatable {
  const UploadResponse({
    this.status,
    this.uploadProgress,
    this.message,
    this.boolFinalize,
    this.boolInitial,
    this.boolSuccess,
  });

  /// Constructor factory para crear una nueva instancia de [UploadResponse]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$UploadResponseFromJson()`.
  factory UploadResponse.fromJson(Map<String, dynamic> json) => _$UploadResponseFromJson(json);

  final String? status;
  final String? uploadProgress;
  final String? message;
  final bool? boolFinalize;
  final bool? boolInitial;
  final bool? boolSuccess;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);

  @override
  List<Object?> get props => [ status, uploadProgress, message, boolFinalize, boolInitial, boolSuccess ];
}
