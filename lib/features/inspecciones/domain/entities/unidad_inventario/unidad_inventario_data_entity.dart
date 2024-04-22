import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class UnidadInventarioDataEntity extends Equatable {
  const UnidadInventarioDataEntity({this.rows});

  final List<UnidadInventarioEntity>? rows;

  @override
  List<Object?> get props => [ rows ];
}
