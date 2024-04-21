import 'package:eos_mobile/shared/shared.dart';

/// [UnidadInventarioEntity]
///
/// Representa los datos de la unidad en inventario que se obtendrá del servidor para
/// realizar diferentes operaciones con la información de la unidad en inventario.
class UnidadInventarioEntity extends Equatable {
  const UnidadInventarioEntity({
    required this.idUnidad,
    required this.numeroEconomico,
    required this.idBase,
    required this.baseName,
    required this.idBaseDestino,
    required this.idUnidadEstatus,
    required this.unidadEstatusName,
    required this.idUnidadTipo,
    required this.unidadTipoName,
    required this.unidadTipoSeccion,
    this.motivoBaja,
    this.placaEstatal,
    this.placaFederal,
    this.idCombustibleTipo,
    this.transferencia,
  });

  final String idUnidad;
  final String numeroEconomico;
  final String idBase;
  final String baseName;
  final String idBaseDestino;
  final String idUnidadEstatus;
  final String unidadEstatusName;
  final String? motivoBaja;
  final String idUnidadTipo;
  final String unidadTipoName;
  final String unidadTipoSeccion;
  final String? placaEstatal;
  final String? placaFederal;
  final String? idCombustibleTipo;
  final bool? transferencia;

  @override
  List<Object?> get props => [
        idUnidad,
        numeroEconomico,
        idBase,
        baseName,
        idBaseDestino,
        idUnidadEstatus,
        unidadEstatusName,
        motivoBaja,
        idUnidadTipo,
        unidadTipoName,
        unidadTipoSeccion,
        placaEstatal,
        placaFederal,
        idCombustibleTipo,
        transferencia,
      ];
}
