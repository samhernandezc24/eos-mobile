import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadIndexEntity extends Equatable {
  const UnidadIndexEntity({
    this.unidadesCapacidadesMedidas,
    this.unidadesMarcas,
    this.unidadesTipos,
    this.usuarios,
  });

  final List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas;
  final List<UnidadMarca>? unidadesMarcas;
  final List<UnidadTipo>? unidadesTipos;
  final List<Usuario>? usuarios;

  @override
  List<Object?> get props => [ unidadesCapacidadesMedidas, unidadesTipos, usuarios ];
}
