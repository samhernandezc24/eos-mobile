import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaEntity]
///
/// Representa la información de la categoría que agrupará las preguntas,
/// para la evaluación de una unidad.
class CategoriaEntity extends Equatable {
  const CategoriaEntity({
    required this.idCategoria,
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
    required this.orden,
  });

  final String idCategoria;
  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;
  final int orden;

  @override
  List<Object?> get props => [
        idCategoria,
        name,
        idInspeccionTipo,
        inspeccionTipoCodigo,
        inspeccionTipoName,
        orden,
      ];
}
