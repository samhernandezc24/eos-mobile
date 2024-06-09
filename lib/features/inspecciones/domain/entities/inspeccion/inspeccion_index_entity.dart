import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source_persistence.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

/// [InspeccionIndexEntity]
///
/// Representa los datos obtenidos del servidor para representar los filtrados dinámicos.
class InspeccionIndexEntity extends Equatable {
  const InspeccionIndexEntity({
    this.dataSourcePersistence,
    this.unidadesTipos,
    this.inspeccionesEstatus,
    this.usuarios,
  });

  final DataSourcePersistence? dataSourcePersistence;
  final List<UnidadTipo>? unidadesTipos;
  final List<InspeccionEstatus>? inspeccionesEstatus;
  final List<Usuario>? usuarios;

  @override
  List<Object?> get props => [ dataSourcePersistence, unidadesTipos, inspeccionesEstatus, usuarios ];
}
