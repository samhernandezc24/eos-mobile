import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class InspeccionCreateEntity extends Equatable {
  const InspeccionCreateEntity({this.inspeccionesTipos});

  final List<InspeccionTipoEntity>? inspeccionesTipos;

  @override
  List<Object?> get props => [ inspeccionesTipos ];
}
