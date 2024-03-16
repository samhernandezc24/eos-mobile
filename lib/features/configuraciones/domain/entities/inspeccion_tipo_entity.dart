import 'package:eos_mobile/shared/shared.dart';

/// [InspeccionTipoEntity]
///
/// Representa el tipo de inspección que se realizará a una unidad de inventario
/// o a una unidad temporal.
class InspeccionTipoEntity extends Equatable {
  const InspeccionTipoEntity({
    required this.idInspeccionTipo,
    required this.folio,
    required this.name,
    this.correo,
  });

  final String idInspeccionTipo;
  final String folio;
  final String name;
  final String? correo;

  @override
  List<Object?> get props => [ idInspeccionTipo, folio, name, correo ];
}
