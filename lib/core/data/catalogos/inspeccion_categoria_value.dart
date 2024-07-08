import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inspeccion_categoria_value.g.dart';

@JsonSerializable()
class InspeccionCategoriaValue extends Equatable {
  const InspeccionCategoriaValue({
    this.idCategoriaItem,
    this.name,
    this.idFormularioTipo,
    this.formularioTipoName,
    this.formularioValor,
    this.value,
    this.observaciones,
    this.noAplica,
  });

  /// Constructor factory para crear una nueva instancia de [InspeccionCategoriaValue]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$InspeccionCategoriaValueFromJson()`.
  factory InspeccionCategoriaValue.fromJson(Map<String, dynamic> json) => _$InspeccionCategoriaValueFromJson(json);

  final String? idCategoriaItem;
  final String? name;
  final String? idFormularioTipo;
  final String? formularioTipoName;
  final String? formularioValor;
  final String? value;
  final String? observaciones;
  final bool? noAplica;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$InspeccionCategoriaValueToJson(this);

  InspeccionCategoriaValue copyWith({
    String? idCategoriaItem,
    String? name,
    String? idFormularioTipo,
    String? formularioTipoName,
    String? formularioValor,
    String? value,
    String? observaciones,
    bool? noAplica,
  }) {
    return InspeccionCategoriaValue(
      idCategoriaItem     : idCategoriaItem     ?? this.idCategoriaItem,
      name                : name                ?? this.name,
      idFormularioTipo    : idFormularioTipo    ?? this.idFormularioTipo,
      formularioTipoName  : formularioTipoName  ?? this.formularioTipoName,
      formularioValor     : formularioValor     ?? this.formularioValor,
      value               : value               ?? this.value,
      observaciones       : observaciones       ?? this.observaciones,
      noAplica            : noAplica            ?? this.noAplica,
    );
  }

  @override
  List<Object?> get props => [
        idCategoriaItem,
        name,
        idFormularioTipo,
        formularioTipoName,
        formularioValor,
        value,
        observaciones,
        noAplica,
      ];
}
