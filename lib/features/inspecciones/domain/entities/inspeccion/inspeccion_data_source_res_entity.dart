import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionDataSourceResEntity extends Equatable {
  const InspeccionDataSourceResEntity({this.rows});

  final List<InspeccionDataSourceEntity>? rows;

  @override
  List<Object?> get props => [ rows ];
}
