import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

/// [InspeccionFicheroEntity]
///
/// Representa la evidencia fotográfica que forma parte del proceso del checklist de
/// la inspección de una unidad.
class InspeccionFicheroEntity extends Equatable {
  const InspeccionFicheroEntity({required this.inspeccion, this.ficheros});

  final InspeccionFichero inspeccion;
  final List<Fichero>? ficheros;

  @override
  List<Object?> get props => [ inspeccion, ficheros ];
}
