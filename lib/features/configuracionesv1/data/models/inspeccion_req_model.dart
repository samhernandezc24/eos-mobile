import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_req_entity.dart';

class InspeccionReqModel extends InspeccionReqEntity {
  const InspeccionReqModel({
    required String idInspeccion,
  }) : super(idInspeccion: idInspeccion);

  /// `toJson` es la convención para que una clase soporte la
  /// serialización a formato JSON.
  Map<String, dynamic> toJson() {
    return {'idInspeccion': idInspeccion};
  }
}
