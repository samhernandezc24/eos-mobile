import 'package:eos_mobile/shared/shared.dart';

/// [InspeccionTipoReqEntity]
///
/// Representa los datos necesarios para solicitar la creación, actualización o eliminación de un tipo
/// de inspección en el servidor. Su propósito es transportar la información requerida
/// para esta operación.
class InspeccionTipoReqEntity extends Equatable {
  const InspeccionTipoReqEntity({
    this.idInspeccionTipo,
    this.folio,
    this.name,
    this.correo,
    this.orden,
  });

  final String? idInspeccionTipo;
  final String? folio;
  final String? name;
  final String? correo;
  final int? orden;

  @override
  List<Object?> get props => [ idInspeccionTipo, folio, name, correo, orden ];
}
