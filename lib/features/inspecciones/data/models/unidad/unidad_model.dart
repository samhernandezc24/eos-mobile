import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';

/// [UnidadModel]
///
/// Representa los datos de la unidad temporal que se obtendrá del servidor para
/// realizar diferentes operaciones con su información.
class UnidadModel extends UnidadEntity {
  const UnidadModel({
    String? idUnidad,
    String? numeroEconomico,
    String? idBase,
    String? baseName,
    String? idUnidadTipo,
    String? unidadTipoName,
    String? idUnidadMarca,
    String? unidadMarcaName,
    String? idUnidadPlacaTipo,
    String? unidadPlacaTipoName,
    String? placa,
    String? numeroSerie,
    String? modelo,
    String? anioEquipo,
    String? descripcion,
  }) : super(
        idUnidad              : idUnidad,
        numeroEconomico       : numeroEconomico,
        idBase                : idBase,
        baseName              : baseName,
        idUnidadTipo          : idUnidadTipo,
        unidadTipoName        : unidadTipoName,
        idUnidadMarca         : idUnidadMarca,
        unidadMarcaName       : unidadMarcaName,
        idUnidadPlacaTipo     : idUnidadPlacaTipo,
        unidadPlacaTipoName   : unidadPlacaTipoName,
        placa                 : placa,
        numeroSerie           : numeroSerie,
        modelo                : modelo,
        anioEquipo            : anioEquipo,
        descripcion           : descripcion,
      );

  /// Constructor factory para crear la instancia de [UnidadModel]
  /// durante el mapeo del JSON.
  factory UnidadModel.fromJson(Map<String, dynamic> jsonMap) {
    return UnidadModel(
      idUnidad              : jsonMap['idUnidad'] as String? ?? '',
      numeroEconomico       : jsonMap['numeroEconomico'] as String? ?? '',
      idBase                : jsonMap['idBase'] as String? ?? '',
      baseName              : jsonMap['baseName'] as String? ?? '',
      idUnidadTipo          : jsonMap['idUnidadTipo'] as String? ?? '',
      unidadTipoName        : jsonMap['unidadTipoName'] as String? ?? '',
      idUnidadMarca         : jsonMap['idUnidadMarca'] as String? ?? '',
      unidadMarcaName       : jsonMap['unidadMarcaName'] as String? ?? '',
      idUnidadPlacaTipo     : jsonMap['idUnidadPlacaTipo'] as String? ?? '',
      unidadPlacaTipoName   : jsonMap['unidadPlacaTipoName'] as String? ?? '',
      placa                 : jsonMap['placa'] as String? ?? '',
      numeroSerie           : jsonMap['numeroSerie'] as String? ?? '',
      modelo                : jsonMap['modelo'] as String? ?? '',
      anioEquipo            : jsonMap['anioEquipo'] as String? ?? '',
      descripcion           : jsonMap['descripcion'] as String? ?? '',
    );
  }

  /// Constructor factory para convertir la instancia de [UnidadEntity]
  /// en una instancia de [UnidadModel].
  factory UnidadModel.fromEntity(UnidadEntity entity) {
    return UnidadModel(
      idUnidad              : entity.idUnidad,
      numeroEconomico       : entity.numeroEconomico,
      idBase                : entity.idBase,
      baseName              : entity.baseName,
      idUnidadTipo          : entity.idUnidadTipo,
      unidadTipoName        : entity.unidadTipoName,
      idUnidadMarca         : entity.idUnidadMarca,
      unidadMarcaName       : entity.unidadMarcaName,
      idUnidadPlacaTipo     : entity.idUnidadPlacaTipo,
      unidadPlacaTipoName   : entity.unidadPlacaTipoName,
      placa                 : entity.placa,
      numeroSerie           : entity.numeroSerie,
      modelo                : entity.modelo,
      anioEquipo            : entity.anioEquipo,
      descripcion           : entity.descripcion,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUnidad'              : idUnidad,
      'numeroEconomico'       : numeroEconomico,
      'idBase'                : idBase,
      'baseName'              : baseName,
      'idUnidadTipo'          : idUnidadTipo,
      'unidadTipoName'        : unidadTipoName,
      'idUnidadMarca'         : idUnidadMarca,
      'unidadMarcaName'       : unidadMarcaName,
      'idUnidadPlacaTipo'     : idUnidadPlacaTipo,
      'unidadPlacaTipoName'   : unidadPlacaTipoName,
      'placa'                 : placa,
      'numeroSerie'           : numeroSerie,
      'modelo'                : modelo,
      'anioEquipo'            : anioEquipo,
      'descripcion'           : descripcion,
    };
  }
}
