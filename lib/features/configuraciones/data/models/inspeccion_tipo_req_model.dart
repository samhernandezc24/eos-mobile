import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';

/// [InspeccionTipoReqModel]
///
/// Representa los datos necesarios para solicitar la creación o actualización de un tipo
/// de inspección en el servidor.
///
/// Esta clase se utiliza para transportar datos entre las capas de datos y de dominio de la
/// aplicación, así como para la serialización y deserialización de objetos JSON.
class InspeccionTipoReqModel extends InspeccionTipoReqEntity {
  const InspeccionTipoReqModel({
    String? idInspeccionTipo,
    String? folio,
    String? name,
    String? correo,
  }) : super(
        idInspeccionTipo  : idInspeccionTipo,
        folio             : folio,
        name              : name,
        correo            : correo,
      );

  /// Constructor factory para convertir la instancia de [InspeccionTipoReqEntity]
  /// en una instancia de [InspeccionTipoReqModel].
  factory InspeccionTipoReqModel.fromEntity(InspeccionTipoReqEntity entity) {
    return InspeccionTipoReqModel(
      idInspeccionTipo  : entity.idInspeccionTipo,
      folio             : entity.folio,
      name              : entity.name,
      correo            : entity.correo,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idInspeccionTipo' : idInspeccionTipo,
      'folio'            : folio,
      'name'             : name,
      'correo'           : correo,
    };
  }
}
