import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionDataEntity extends Equatable {
  const InspeccionDataEntity({this.inspeccionesTipos});

  final List<InspeccionTipoEntity>? inspeccionesTipos;

  @override
  List<Object?> get props => [ inspeccionesTipos ];
}
