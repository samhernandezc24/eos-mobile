import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionFicheroIdReqEntity extends Equatable {
  const InspeccionFicheroIdReqEntity({required this.idInspeccionFichero});

  final String idInspeccionFichero;

  @override
  List<Object?> get props => [ idInspeccionFichero ];
}
