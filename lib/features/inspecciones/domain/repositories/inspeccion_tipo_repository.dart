import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';

abstract class InspeccionTipoRepository {
  /// API METHODS
  Future<DataState<List<InspeccionTipoEntity>>> listInspeccionesTipos();

  /// LOCAL METHODS
}
