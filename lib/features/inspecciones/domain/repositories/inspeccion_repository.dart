import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_entity.dart';

abstract class InspeccionRepository {
  /// API METHODS
  Future<DataState<InspeccionDataEntity>> createInspeccion();

  /// LOCAL METHODS
}
