import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_entity.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

/// [InspeccionDataSourceEntity]
///
/// Representa la información de construcción de la UI para el listado de inspecciones con información
/// adicional como paginadores.
class InspeccionDataSourceEntity extends Equatable {
  const InspeccionDataSourceEntity({
    this.rows,
    this.count,
    this.length,
    this.pages,
    this.page,
  });

  final List<InspeccionEntity>? rows;
  final int? count;
  final int? length;
  final int? pages;
  final int? page;

  @override
  List<Object?> get props => [ rows, count, length, pages, page ];
}
