import 'package:eos_mobile/shared/shared_libraries.dart';

/// [InspeccionTipoEntity]
///
/// Representa el tipo de inspección que se aplicará para evaluar una unidad.
class InspeccionTipoEntity extends Equatable {
  const InspeccionTipoEntity({
    required this.idInspeccionTipo,
    required this.codigo,
    required this.name,
    this.orden,
  });

  final String idInspeccionTipo;
  final String codigo;
  final String name;
  final int? orden;

  @override
  List<Object?> get props => [ idInspeccionTipo, codigo, name, orden ];
}
