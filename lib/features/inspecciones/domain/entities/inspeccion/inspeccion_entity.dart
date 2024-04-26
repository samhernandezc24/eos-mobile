import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionEntity extends Equatable {
  const InspeccionEntity({
    required this.idInspeccion,
    required this.folio,
  });

  final String idInspeccion;
  final String folio;

  @override
  List<Object?> get props => [ idInspeccion, folio ];
}
