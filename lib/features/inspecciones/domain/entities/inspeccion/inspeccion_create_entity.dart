import 'package:eos_mobile/core/data/catalogos/unidad_capacidad_medida.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/shared/shared_libs.dart';

/// [InspeccionCreateEntity]
///
/// Representa los listados tanto de los tipos de inspección como las unidades capacidades medidas,
/// necesarios para la creación de una inspección.
class InspeccionCreateEntity extends Equatable {
  const InspeccionCreateEntity({this.inspeccionesTipos, this.unidadesCapacidadesMedidas});

  final List<InspeccionTipoEntity>? inspeccionesTipos;
  final List<UnidadCapacidadMedida>? unidadesCapacidadesMedidas;

  @override
  List<Object?> get props => [ inspeccionesTipos, unidadesCapacidadesMedidas ];
}
