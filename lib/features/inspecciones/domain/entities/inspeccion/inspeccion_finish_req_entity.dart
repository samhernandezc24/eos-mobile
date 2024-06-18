import 'package:eos_mobile/shared/shared_libraries.dart';

/// [InspeccionFinishReqEntity]
///
/// Representa la estructura de datos que se enviará al servidor para finalizar
/// la inspección.
class InspeccionFinishReqEntity extends Equatable {
  const InspeccionFinishReqEntity({
    required this.idInspeccion,
    required this.fechaInspeccionFinal,
    required this.firmaVerificador,
    required this.firmaOperador,
    required this.fileExtensionVerificador,
    required this.fileExtensionOperador,
    this.observaciones,
  });

  final String idInspeccion;
  final DateTime fechaInspeccionFinal;
  final String firmaVerificador;
  final String firmaOperador;
  final String fileExtensionVerificador;
  final String fileExtensionOperador;
  final String? observaciones;

  @override
  List<Object?> get props => [
        idInspeccion,
        fechaInspeccionFinal,
        firmaVerificador,
        firmaOperador,
        fileExtensionVerificador,
        fileExtensionOperador,
        observaciones,
      ];
}
