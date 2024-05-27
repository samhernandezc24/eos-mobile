import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoria_item_value.g.dart';

@JsonSerializable()
class CategoriaItemValue extends Equatable {
  const CategoriaItemValue({
    this.idCategoriaItem,
    this.name,
    this.idFormularioTipo,
    this.formularioTipoName,
    this.formularioValor,
    this.value,
  });

  /// Constructor factory para crear una nueva instancia de [CategoriaItemValue]
  /// a partir de un mapa. Pasa el mapa al constructor generado `_$CategoriaItemValueFromJson()`.
  factory CategoriaItemValue.fromJson(Map<String, dynamic> json) => _$CategoriaItemValueFromJson(json);

  final String? idCategoriaItem;
  final String? name;
  final String? idFormularioTipo;
  final String? formularioTipoName;
  final String? formularioValor;
  final String? value;

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() => _$CategoriaItemValueToJson(this);

  @override
  List<Object?> get props => [
        idCategoriaItem,
        name,
        idFormularioTipo,
        formularioTipoName,
        formularioValor,
        value,
      ];
}
