import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoria_item.g.dart';

@JsonSerializable()
class CategoriaItem extends Equatable {
  const CategoriaItem({
    this.idCategoriaItem,
    this.name,
    this.idFormularioTipo,
    this.formularioTipoName,
    this.formularioValor,
    this.value,
    this.observaciones,
    this.noAplica,
  });

  /// Constructor factory para crear una nueva instancia de [CategoriaItem]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$CategoriaItemFromJson()`.
  factory CategoriaItem.fromJson(Map<String, dynamic> json) => _$CategoriaItemFromJson(json);

  final String? idCategoriaItem;
  final String? name;
  final String? idFormularioTipo;
  final String? formularioTipoName;
  final String? formularioValor;
  final String? value;
  final String? observaciones;
  final bool? noAplica;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$CategoriaItemToJson(this);

  CategoriaItem copyWith({
    String? idCategoriaItem,
    String? name,
    String? idFormularioTipo,
    String? formularioTipoName,
    String? formularioValor,
    String? value,
    String? observaciones,
    bool? noAplica,
  }) {
    return CategoriaItem(
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
