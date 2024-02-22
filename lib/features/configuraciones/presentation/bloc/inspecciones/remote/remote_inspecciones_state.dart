import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteInspeccionesState extends Equatable {
  const RemoteInspeccionesState({this.inspecciones, this.failure});

  final List<InspeccionEntity>? inspecciones;
  final DioException? failure;

  @override

  @override
  List<Object> get props => [inspecciones!, failure!];
}

class RemoteInspeccionesLoading extends RemoteInspeccionesState {
  const RemoteInspeccionesLoading();
}

class RemoteInspeccionesDone extends RemoteInspeccionesState {
  const RemoteInspeccionesDone(List<InspeccionEntity> inspeccion) : super(inspecciones: inspeccion);
}

class RemoteInspeccionesFailure extends RemoteInspeccionesState {
  const RemoteInspeccionesFailure(DioException failure) : super(failure: failure);
}
