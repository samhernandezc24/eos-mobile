import 'package:eos_mobile/shared/shared_libraries.dart';

/// [InspeccionTipoReqEntity]
///
/// Representa los datos de la request para tipo de inspección, se mandara esta informacion
/// en el body de la petición.
class InspeccionTipoReqEntity extends Equatable {
  const InspeccionTipoReqEntity({
    required this.codigo,
    required this.name,
  });

  final String codigo;
  final String name;

  @override
  List<Object?> get props => [ codigo, name ];
}
