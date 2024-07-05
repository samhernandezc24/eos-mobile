import 'package:eos_mobile/shared/shared_libs.dart';

/// [InspeccionTipoStoreReqEntity]
///
/// Representa la información para crear un tipo de inspección, su propósito es transportar
/// la información requerida para su creación.
class InspeccionTipoStoreReqEntity extends Equatable {
  const InspeccionTipoStoreReqEntity({required this.codigo, required this.name});

  final String codigo;
  final String name;

  @override
  List<Object?> get props => [ codigo, name ];
}
