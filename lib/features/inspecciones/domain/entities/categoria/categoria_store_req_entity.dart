import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaStoreReqEntity]
///
/// Representa la información para crear una categoría, su propósito es transportar
/// la información requerida para su creación.
class CategoriaStoreReqEntity extends Equatable {
  const CategoriaStoreReqEntity({
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
    required this.orden,
  });

  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;
  final int orden;

  @override
  List<Object?> get props => [
        name,
        idInspeccionTipo,
        inspeccionTipoCodigo,
        inspeccionTipoName,
        orden,
      ];
}
