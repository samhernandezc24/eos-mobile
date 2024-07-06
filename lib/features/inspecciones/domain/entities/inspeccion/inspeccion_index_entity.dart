import 'package:eos_mobile/core/data/catalogos/inspeccion_estatus.dart';
import 'package:eos_mobile/core/data/catalogos/unidad_tipo.dart';
import 'package:eos_mobile/core/data/catalogos/usuario.dart';
import 'package:eos_mobile/core/data/data_source/data_source_persistence.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

/// [InspeccionIndexEntity]
///
/// Representa la información de inicialización como listados para los filtros,
/// datos persistentes obtenidos del servidor para el data source de inspecciones.
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
