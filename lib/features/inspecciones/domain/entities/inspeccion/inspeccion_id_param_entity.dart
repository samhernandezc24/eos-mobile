import 'package:eos_mobile/shared/shared_libs.dart';

/// [InspeccionIdParamEntity]
///
/// Representa el [idInspeccion] de la inspeccion para operaciones como edición o
/// eliminación donde solo debe pasarse el [idInspeccion] como parámetro
/// en la solicitud.
class InspeccionIdParamEntity extends Equatable {
  const InspeccionIdParamEntity({required this.idInspeccion});

  final String idInspeccion;

  @override
  List<Object?> get props => [ idInspeccion ];
}
