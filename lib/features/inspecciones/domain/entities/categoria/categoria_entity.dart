import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaEntity]
///
/// Representa la categoría que clasificará las preguntas del formulario de las
/// inspecciones.
class CategoriaEntity extends Equatable {
  const CategoriaEntity({
    required this.idCategoria,
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoCodigo,
    required this.inspeccionTipoName,
    this.orden,
  });

  final String idCategoria;
  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoCodigo;
  final String inspeccionTipoName;
  final int? orden;

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
