import 'package:eos_mobile/shared/shared.dart';

class InspeccionEntity extends Equatable {
  const InspeccionEntity({
    this.folio,
    this.name,
    this.idInspeccion,
  });

  final String? idInspeccion;
  final String? folio;
  final String? name;

  @override
  List<Object?> get props => [
        idInspeccion,
        folio,
        name,
      ];
}
