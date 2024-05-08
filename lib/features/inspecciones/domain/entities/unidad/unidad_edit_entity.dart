import 'package:eos_mobile/core/data/catalogos/base.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_marca.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_edit_res_entity.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadEditEntity extends Equatable {
  const UnidadEditEntity({this.unidad, this.bases, this.unidadesCapacidadesMedidas, this.unidadesMarcas, this.unidadesTipos});

  final UnidadEditResEntity? unidad;
  final List<Base>? bases;
  final List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas;
  final List<UnidadMarca>? unidadesMarcas;
  final List<UnidadTipo>? unidadesTipos;

  @override
  List<Object?> get props => [ unidad, bases, unidadesCapacidadesMedidas, unidadesMarcas, unidadesTipos ];
}
