import 'package:eos_mobile/shared/shared.dart';

/// [UnidadEntity]
///
/// Representa los datos de la unidad temporal que se obtendrá del servidor para
/// realizar diferentes operaciones con su información.
class UnidadEntity extends Equatable {
  const UnidadEntity({
    this.idUnidad,
    this.numeroEconomico,
    this.idBase,
    this.baseName,
    this.idUnidadTipo,
    this.unidadTipoName,
    this.idUnidadMarca,
    this.unidadMarcaName,
    this.idUnidadPlacaTipo,
    this.unidadPlacaTipoName,
    this.placa,
    this.numeroSerie,
    this.modelo,
    this.anioEquipo,
    this.descripcion,
  });

  final String? idUnidad;
  final String? numeroEconomico;
  final String? idBase;
  final String? baseName;
  final String? idUnidadTipo;
  final String? unidadTipoName;
  final String? idUnidadMarca;
  final String? unidadMarcaName;
  final String? idUnidadPlacaTipo;
  final String? unidadPlacaTipoName;
  final String? placa;
  final String? numeroSerie;
  final String? modelo;
  final String? anioEquipo;
  final String? descripcion;

  @override
  List<Object?> get props => [
        idUnidad,
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
      ];
}
