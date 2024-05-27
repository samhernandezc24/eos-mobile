import 'package:eos_mobile/core/data/inspeccion/categoria_value.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';

/// [InspeccionCategoriaStoreReqModel]
///
/// Representa el modelo de datos que se enviará al servidor para guardar la
/// evaluación de la inspección.
class InspeccionCategoriaStoreReqModel extends InspeccionCategoriaStoreReqEntity {
  const InspeccionCategoriaStoreReqModel({
    required String idInspeccion,
    required bool isParcial,
    required DateTime fechaInspeccionInicial,
    required List<CategoriaValue> categorias,
    DateTime? fechaInspeccionFinal,
  }) : super(
          idInspeccion            : idInspeccion,
          isParcial               : isParcial,
          fechaInspeccionInicial  : fechaInspeccionInicial,
          fechaInspeccionFinal    : fechaInspeccionFinal,
          categorias              : categorias,
        );

  /// Constructor factory para crear la instancia de [InspeccionCategoriaStoreReqModel]
  /// durante el mapeo del JSON.
  factory InspeccionCategoriaStoreReqModel.fromJson(Map<String, dynamic> jsonMap) {
    return InspeccionCategoriaStoreReqModel(
      idInspeccion            : jsonMap['idInspeccion'] as String,
      isParcial               : jsonMap['isParcial'] as bool,
      fechaInspeccionInicial  : DateTime.parse(jsonMap['fechaInspeccionInicial'] as String),
      fechaInspeccionFinal    : jsonMap['fechaInspeccionFinal'] != null ? DateTime.parse(jsonMap['fechaInspeccionFinal'] as String) : null,
      categorias              : (jsonMap['categorias'] as List<dynamic>).map((item) => CategoriaValue.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Constructor factory para crear la instancia de [InspeccionCategoriaStoreReqEntity]
  /// en una instancia de [InspeccionCategoriaStoreReqModel].
  factory InspeccionCategoriaStoreReqModel.fromEntity(InspeccionCategoriaStoreReqEntity entity) {
    return InspeccionCategoriaStoreReqModel(
      idInspeccion            : entity.idInspeccion,
      isParcial               : entity.isParcial,
      fechaInspeccionInicial  : entity.fechaInspeccionInicial,
      fechaInspeccionFinal    : entity.fechaInspeccionFinal,
      categorias              : entity.categorias,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idInspeccion'            : idInspeccion,
      'isParcial'               : isParcial,
      'fechaInspeccionInicial'  : fechaInspeccionInicial.toIso8601String(),
      'fechaInspeccionFinal'    : fechaInspeccionFinal?.toIso8601String(),
      'categorias'              : categorias.map((e) => e.toJson()).toList(),
    };
  }
}
