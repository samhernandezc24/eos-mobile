import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';

class InspeccionModel extends InspeccionEntity {
  const InspeccionModel({
    required String folio,
    required String name,
    String? idInspeccion,
  }) : super(
          idInspeccion: idInspeccion,
          folio:          folio,
          name:           name,
        );

  /// Un constructor de factory necesario para crear una instancia
  /// de [InspeccionModel] para el mapeo de json.
  factory InspeccionModel.fromJson(Map<String, dynamic> json) {
    return InspeccionModel(
      idInspeccion:   json['idInspeccion'] as String,
      folio:          json['folio'] as String,
      name:           json['name'] as String,
    );
  }

  factory InspeccionModel.fromEntity(InspeccionEntity entity) {
    return InspeccionModel(
      idInspeccion:   entity.idInspeccion,
      folio:          entity.folio,
      name:           entity.name,
    );
  }

  /// `toJson` es la convención para que una clase soporte la
  /// serialización a formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'idInspeccion':   idInspeccion,
      'folio':          folio,
      'name':           name,
    };
  }
}
