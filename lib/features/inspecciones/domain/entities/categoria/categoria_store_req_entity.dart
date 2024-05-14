import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaStoreReqEntity]
///
/// Representa la estructura de datos que se enviará al servidor de la categoría.
class CategoriaStoreReqEntity extends Equatable {
  const CategoriaStoreReqEntity({
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
  });

  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;

  @override
  List<Object?> get props => [
        name,
        idInspeccionTipo,
        inspeccionTipoCodigo,
        inspeccionTipoName,
      ];
}
