import 'package:eos_mobile/shared/shared_libs.dart';

/// [CategoriaUpdateReqEntity]
///
/// Representa la información para actualizar la categoría, su propósito es transportar
/// la información requerida para su actualización.
class CategoriaUpdateReqEntity extends Equatable {
  const CategoriaUpdateReqEntity({
    required this.idInspeccionTipo,
    required this.idCategoria,
    required this.name,
  });

  final String idInspeccionTipo;
  final String idCategoria;
  final String name;

  @override
  List<Object?> get props => [
        idInspeccionTipo,
        idCategoria,
        name,
      ];
}
