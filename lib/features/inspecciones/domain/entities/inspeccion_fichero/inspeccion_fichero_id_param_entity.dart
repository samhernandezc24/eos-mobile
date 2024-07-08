import 'package:eos_mobile/shared/shared_libs.dart';

/// [InspeccionFicheroIdParamEntity]
///
/// Representa el [idInspeccionFichero] de la fotografía de una inspección para operaciones como edición o
/// eliminación donde solo debe pasarse el [idInspeccionFichero] como parámetro
/// en la solicitud.
class InspeccionFicheroIdParamEntity extends Equatable {
  const InspeccionFicheroIdParamEntity({required this.idInspeccionFichero});

  final String idInspeccionFichero;

  @override
  List<Object?> get props => [ idInspeccionFichero ];
}
