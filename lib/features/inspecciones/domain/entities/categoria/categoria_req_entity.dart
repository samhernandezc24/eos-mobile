import 'package:eos_mobile/shared/shared.dart';

/// [CategoriaReqEntity]
///
/// Representa los datos de la request para la categoría, se mandara esta informacion
/// en el body de la petición.
class CategoriaReqEntity extends Equatable {
  const CategoriaReqEntity({
    required this.name,
    required this.idInspeccionTipo,
    required this.inspeccionTipoName,
    required this.inspeccionTipoFolio,
  });

  final String name;
  final String idInspeccionTipo;
  final String inspeccionTipoName;
  final String inspeccionTipoFolio;

  @override
  List<Object?> get props => [ name, idInspeccionTipo, inspeccionTipoName, inspeccionTipoFolio ];
}
