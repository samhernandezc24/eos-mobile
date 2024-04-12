import 'package:eos_mobile/shared/shared.dart';

/// [UnidadReqEntity]
///
/// Representa los datos de la request para la unidad (temporal), se mandara esta informacion
/// en el body de la petición.
class UnidadReqEntity extends Equatable {
  const UnidadReqEntity({
    required this.numeroEconomico,
    required this.numeroSerie,
    required this.modelo,
    required this.idBase,
    required this.baseName,
    required this.idUnidadMarca,
    required this.unidadMarcaName,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    this.descripcion,
    this.anioEquipo,
    this.capacidad,
    this.horometro,
    this.odometro,
  });

  final String numeroEconomico;
  final String numeroSerie;
  final String? descripcion;
  final String modelo;
  final String? anioEquipo;
  final String idBase;
  final String baseName;
  final String idUnidadMarca;
  final String unidadMarcaName;
  final String idUnidadTipo;
  final String unidadTipoName;
  final double? capacidad;
  final int? horometro;
  final int? odometro;

  @override
  List<Object?> get props => [
        numeroEconomico,
        numeroSerie,
        descripcion,
        modelo,
        anioEquipo,
        idBase,
        baseName,
        idUnidadMarca,
        unidadMarcaName,
        idUnidadTipo,
        unidadTipoName,
        capacidad,
        horometro,
        odometro,
      ];
}
