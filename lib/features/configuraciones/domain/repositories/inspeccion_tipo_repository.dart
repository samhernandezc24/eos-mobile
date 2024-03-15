import 'package:dartz/dartz.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/failures.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';

abstract class InspeccionTipoRepository {
  /// API METHODS
  Future<Either<Failure, DataState<List<InspeccionTipoEntity>>>> fetchInspeccionesTipos();
}
