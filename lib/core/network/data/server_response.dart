import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_response.g.dart';

@JsonSerializable()
class ServerResponse extends Equatable {
  const ServerResponse({
    this.session,
    this.action,
    this.result,
    this.title,
    this.message,
    this.code,
  });

  /// Constructor factory para crear una nueva instancia de [ServerResponse]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$ServerResponseFromJson()`.
  factory ServerResponse.fromJson(Map<String, dynamic> json) => _$ServerResponseFromJson(json);

  final bool? session;
  final bool? action;
  final dynamic result;
  final String? title;
  final String? message;
  final String? code;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$ServerResponseToJson(this);

  @override
  List<Object?> get props => [ session, action, result, title, message, code ];
}
