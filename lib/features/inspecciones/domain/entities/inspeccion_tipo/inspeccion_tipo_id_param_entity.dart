import 'package:eos_mobile/shared/shared_libs.dart';

/// [InspeccionTipoIdParamEntity]
///
/// Representa el [idInspeccionTipo] del tipo de inspección para operaciones como edición o
/// eliminación donde solo debe pasarse el [idInspeccionTipo] como parámetro
/// en la solicitud.
class InspeccionTipoIdParamEntity extends Equatable {
  const InspeccionTipoIdParamEntity({required this.idInspeccionTipo});

  final String idInspeccionTipo;

  @override
  List<Object?> get props => [ idInspeccionTipo ];
}
