import 'package:eos_mobile/shared/shared_libraries.dart';

/// [InspeccionFicheroStoreReqEntity]
///
/// Representa la solicitud para almacenar un fichero (fotografía) asociada a una
/// inspección.
class InspeccionFicheroStoreReqEntity extends Equatable {
  const InspeccionFicheroStoreReqEntity({
    required this.fileBase64,
    required this.fileExtension,
    required this.idInspeccion,
    required this.inspeccionFolio,
  });

  final String fileBase64;
  final String fileExtension;
  final String idInspeccion;
  final String inspeccionFolio;

  @override
  List<Object?> get props => [ fileBase64, fileExtension, idInspeccion, inspeccionFolio ];
}
