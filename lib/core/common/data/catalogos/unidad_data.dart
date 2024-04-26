// ignore_for_file: avoid_dynamic_calls

import 'package:eos_mobile/core/common/data/catalogos/base_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_marca_data.dart';
import 'package:eos_mobile/core/common/data/catalogos/unidad_tipo_data.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadDataModel extends UnidadDataEntity {
  const UnidadDataModel({
    required List<BaseDataModel> bases,
    required List<UnidadMarcaDataModel> unidadesMarcas,
    required List<UnidadTipoDataModel> unidadesTipos,
  }) : super(
        bases           : bases,
        unidadesMarcas  : unidadesMarcas,
        unidadesTipos   : unidadesTipos,
      );

  /// Constructor factory para crear la instancia de [UnidadDataModel]
  /// durante el mapeo del JSON.
  factory UnidadDataModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadDataModel(
      bases           : (jsonMap['bases'] as List<dynamic>).map((item) => BaseDataModel.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesMarcas  : (jsonMap['unidadesMarcas'] as List<dynamic>).map((item) => UnidadMarcaDataModel.fromJson(item as Map<String, dynamic>)).toList(),
      unidadesTipos   : (jsonMap['unidadesTipos'] as List<dynamic>).map((item) => UnidadTipoDataModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bases'           : bases,
      'unidadesMarcas'  : unidadesMarcas,
      'unidadesTipos'   : unidadesTipos,
    };
  }
}

@immutable
class UnidadDataEntity extends Equatable {
  const UnidadDataEntity({required this.bases, required this.unidadesMarcas, required this.unidadesTipos});

  final List<BaseDataEntity> bases;
  final List<UnidadMarcaDataEntity> unidadesMarcas;
  final List<UnidadTipoDataEntity> unidadesTipos;

  @override
  List<Object?> get props => [ bases, unidadesMarcas, unidadesTipos ];
}
