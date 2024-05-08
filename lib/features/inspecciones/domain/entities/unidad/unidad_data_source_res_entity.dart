import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_data_source_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadDataSourceResEntity extends Equatable {
  const UnidadDataSourceResEntity({this.rows, this.count, this.length, this.pages, this.page});

  final List<UnidadDataSourceEntity>? rows;
  final int? count;
  final int? length;
  final int? pages;
  final int? page;

  @override
  List<Object?> get props => [ rows, count, length, pages, page ];
}
