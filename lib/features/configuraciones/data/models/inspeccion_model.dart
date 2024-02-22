import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';

class InspeccionModel extends InspeccionEntity {
  const InspeccionModel({
    required String idInspeccion,
    required String folio,
    required String name,
  }) : super(
          idInspeccion:   idInspeccion,
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
