import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaReqEntity]
///
/// Representa los datos necesarios para solicitar el listado por id, creación o actualización de una
/// categoría de tipo de inspección en el servidor. Su propósito es transportar la información requerida
/// para esta operación.
class CategoriaReqEntity extends Equatable {
  const CategoriaReqEntity({
    this.idCategoria,
    this.name,
    this.idInspeccionTipo,
    this.inspeccionTipoFolio,
    this.inspeccionTipoName,
  });

  final String? idCategoria;
  final String? name;
  final String? idInspeccionTipo;
  final String? inspeccionTipoFolio;
  final String? inspeccionTipoName;

  @override
  List<Object?> get props => [ idCategoria, name, idInspeccionTipo, inspeccionTipoFolio, inspeccionTipoName ];
}
