import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';

abstract class InspeccionRepository {
  // API METHODS
  Future<DataState<List<InspeccionEntity>>> getInspecciones();
  Future<DataState<void>> createInspeccion(InspeccionEntity inspeccion);
}
