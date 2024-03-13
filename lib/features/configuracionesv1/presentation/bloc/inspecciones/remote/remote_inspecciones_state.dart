import 'package:eos_mobile/core/data/api_response_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteInspeccionesState extends Equatable {
  const RemoteInspeccionesState({this.inspecciones, this.response, this.failure});

  final List<InspeccionEntity>? inspecciones;
  final ApiResponseEntity? response;
  final DioException? failure;

  @override
  List<Object?> get props => [inspecciones, response, failure];
}

class RemoteInspeccionesLoading extends RemoteInspeccionesState {
  const RemoteInspeccionesLoading();
}

class RemoteInspeccionesDone extends RemoteInspeccionesState {
  const RemoteInspeccionesDone(
    List<InspeccionEntity> inspeccion,
  ) : super(inspecciones: inspeccion);
}

class RemoteInspeccionesCreateDone extends RemoteInspeccionesState {
  const RemoteInspeccionesCreateDone(ApiResponseEntity response)
      : super(response: response);
}

class RemoteInspeccionesRemoveDone extends RemoteInspeccionesState {
  const RemoteInspeccionesRemoveDone(ApiResponseEntity response)
      : super(response: response);
}

class RemoteInspeccionesFailure extends RemoteInspeccionesState {
  const RemoteInspeccionesFailure(DioException failure)
      : super(failure: failure);
}
