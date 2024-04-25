import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class UnidadPredictiveDataEntity extends Equatable {
  const UnidadPredictiveDataEntity({this.rows});

  final List<UnidadEntity>? rows;

  @override
  List<Object?> get props => [ rows ];
}
