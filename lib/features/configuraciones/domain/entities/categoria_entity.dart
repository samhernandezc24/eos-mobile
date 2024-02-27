import 'package:eos_mobile/shared/shared.dart';

class CategoriaEntity extends Equatable {
  const CategoriaEntity({
    required this.name,
    this.idInspeccionCategoria,
    this.idInspeccion,
    this.inspeccionFolio,
    this.inspeccionName,
  });

  final String? idInspeccionCategoria;
  final String name;
  final String? idInspeccion;
  final String? inspeccionFolio;
  final String? inspeccionName;

  @override
  List<Object?> get props => [
        idInspeccionCategoria,
        name,
        idInspeccion,
        inspeccionFolio,
        inspeccionName,
      ];
}
