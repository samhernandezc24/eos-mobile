import 'package:eos_mobile/shared/shared.dart';

/// [InspeccionTipoReqEntity]
///
/// Representa los datos de la request para tipo de inspección, se mandara esta informacion
/// en el body de la petición.
class InspeccionTipoReqEntity extends Equatable {
  const InspeccionTipoReqEntity({
    required this.folio,
    required this.name,
    this.correo,
    this.orden,
  });

  final String folio;
  final String name;
  final String? correo;
  final int? orden;

  @override
  List<Object?> get props => [ folio, name, correo, orden ];
}
