import 'package:eos_mobile/shared/shared_libraries.dart';

/// [CategoriaReqEntity]
///
/// Representa los datos de la request para la categoría, se mandara esta informacion
/// en el body de la petición.
class CategoriaReqEntity extends Equatable {
  const CategoriaReqEntity({
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
  List<Object?> get props => [ name, idInspeccionTipo, inspeccionTipoCodigo, inspeccionTipoName ];
}
