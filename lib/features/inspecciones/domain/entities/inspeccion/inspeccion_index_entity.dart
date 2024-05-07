import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionIndexEntity extends Equatable {
  const InspeccionIndexEntity({
    this.dataSourcePersistence,
    this.unidadesTipos,
    this.inspeccionesEstatus,
    this.unidadesCapacidadesMedidas,
    this.usuarios,
  });

  final DataSourcePersistence? dataSourcePersistence;
  final List<UnidadTipo>? unidadesTipos;
  final List<InspeccionEstatus>? inspeccionesEstatus;
  final List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas;
  final List<Usuario>? usuarios;

  @override
  List<Object?> get props => [ dataSourcePersistence, unidadesTipos, inspeccionesEstatus, unidadesCapacidadesMedidas, usuarios ];
}
