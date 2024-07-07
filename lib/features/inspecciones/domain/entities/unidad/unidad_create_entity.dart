import 'package:eos_mobile/core/data/catalogos/base.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

/// [UnidadCreateEntity]
///
/// Representa los listados de bases, unidades capacidades medidas, marcas, tipo de unidades,
/// necesarios para la creación de una unidad (temporal).
class UnidadCreateEntity extends Equatable {
  const UnidadCreateEntity({this.bases, this.unidadesCapacidadesMedidas, this.unidadesMarcas, this.unidadesTipos});

  final List<Base>? bases;
  final List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas;
  final List<UnidadMarca>? unidadesMarcas;
  final List<UnidadTipo>? unidadesTipos;

  @override
  List<Object?> get props => [ bases, unidadesCapacidadesMedidas, unidadesMarcas, unidadesTipos ];
}
