import 'package:eos_mobile/shared/shared_libraries.dart';

/// [UnidadReqEntity]
///
/// Representa los datos de la request para la unidad (temporal), se mandara esta informacion
/// en el body de la petición.
class UnidadReqEntity extends Equatable {
  const UnidadReqEntity({
    required this.numeroEconomico,
    required this.idBase,
    required this.baseName,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    this.idUnidadMarca,
    this.unidadMarcaName,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.numeroSerie,
    this.modelo,
    this.anioEquipo,
    this.descripcion,
    this.capacidad,
    this.odometro,
    this.horometro,
  });

  final String numeroEconomico;
  final String idBase;
  final String baseName;
  final String idUnidadTipo;
  final String unidadTipoName;
  final String? idUnidadMarca;
  final String? unidadMarcaName;
  final String? idUnidadPlacaTipo;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String? numeroSerie;
  final String? modelo;
  final String? anioEquipo;
  final String? descripcion;
  final double? capacidad;
  final int? odometro;
  final int? horometro;

  @override
  List<Object?> get props => [
        numeroEconomico,
        idBase,
        baseName,
        idUnidadTipo,
        unidadTipoName,
        idUnidadMarca,
        unidadMarcaName,
        idUnidadPlacaTipo,
        unidadPlacaTipoName,
        placa,
        numeroSerie,
        modelo,
        anioEquipo,
        descripcion,
        capacidad,
        odometro,
        horometro,
      ];
}
