import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';

class CategoriaModel extends CategoriaEntity {
  const CategoriaModel({
    required String name,
    String? idInspeccionCategoria,
    String? idInspeccion,
    String? inspeccionFolio,
    String? inspeccionName,
  }) : super(
          idInspeccionCategoria:  idInspeccionCategoria,
          name:                   name,
          idInspeccion:           idInspeccion,
          inspeccionFolio:        inspeccionFolio,
          inspeccionName:         inspeccionName,
        );

  /// Un constructor de factory necesario para crear una instancia
  /// de [CategoriaModel] para el mapeo de json.
  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      idInspeccionCategoria:  json['idInspeccionCategoria'] as String,
      name:                   json['name'] as String,
      idInspeccion:           json['idInspeccion'] as String,
      inspeccionFolio:        json['inspeccionFolio'] as String,
      inspeccionName:         json['inspeccionName'] as String,
    );
  }

  factory CategoriaModel.fromEntity(CategoriaEntity entity) {
    return CategoriaModel(
      idInspeccionCategoria:  entity.idInspeccionCategoria,
      name:                   entity.name,
      idInspeccion:           entity.idInspeccion,
      inspeccionFolio:        entity.inspeccionFolio,
      inspeccionName:         entity.inspeccionName,
    );
  }

  /// `toJson` es la convención para que una clase soporte la
  /// serialización a formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'idInspeccionCategoria':  idInspeccionCategoria,
      'name':                   name,
      'idInspeccion':           idInspeccion,
      'inspeccionFolio':        inspeccionFolio,
      'inspeccionName':         inspeccionName,
    };
  }
}
