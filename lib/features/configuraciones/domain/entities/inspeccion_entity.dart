import 'package:eos_mobile/shared/shared.dart';

class InspeccionEntity extends Equatable {
  const InspeccionEntity({
    required this.idInspeccion,
    required this.folio,
    required this.name,
  });

  final String idInspeccion;
  final String folio;
  final String name;

  @override
  List<Object?> get props => [
        idInspeccion,
        folio,
        name,
      ];
}
