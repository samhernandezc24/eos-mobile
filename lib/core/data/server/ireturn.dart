import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ireturn.g.dart';

@JsonSerializable()
class IReturn extends Equatable {
  const IReturn({
    this.session,
    this.action,
    this.result,
    this.title,
    this.message,
    this.code,
  });

  /// Constructor factory para crear una nueva instancia de [IReturn]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$IReturnFromJson()`.
  factory IReturn.fromJson(Map<String, dynamic> json) => _$IReturnFromJson(json);

  final bool? session;
  final bool? action;
  final dynamic result;
  final String? title;
  final String? message;
  final String? code;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$IReturnToJson(this);

  @override
  List<Object?> get props => [ session, action, result, title, message, code ];
}
