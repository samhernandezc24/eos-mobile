import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class UnidadDataEntity extends Equatable {
  const UnidadDataEntity({this.rows});

  final List<UnidadEntity>? rows;

  @override
  List<Object?> get props => [];
}
