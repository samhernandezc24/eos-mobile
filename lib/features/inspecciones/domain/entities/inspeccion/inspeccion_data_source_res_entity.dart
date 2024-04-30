import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionDataSourceResEntity extends Equatable {
  const InspeccionDataSourceResEntity({this.rows, this.count, this.length, this.pages, this.page});

  final List<InspeccionDataSourceEntity>? rows;
  final int? count;
  final int? length;
  final int? pages;
  final int? page;

  @override
  List<Object?> get props => [ rows, count, length, pages, page ];
}
