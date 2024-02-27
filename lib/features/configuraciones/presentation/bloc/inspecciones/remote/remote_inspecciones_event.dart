import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_req_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteInspeccionesEvent extends Equatable {
  const RemoteInspeccionesEvent({this.inspeccion, this.idInspeccion});

  final InspeccionEntity? inspeccion;
  final InspeccionReqEntity? idInspeccion;

  @override
  List<Object?> get props => [inspeccion, idInspeccion];
}

class GetInspecciones extends RemoteInspeccionesEvent {
  const GetInspecciones();
}

class CreateInspeccion extends RemoteInspeccionesEvent {
  const CreateInspeccion(InspeccionEntity inspeccion) : super(inspeccion: inspeccion);
}

class RemoveInspeccion extends RemoteInspeccionesEvent {
  const RemoveInspeccion(InspeccionReqEntity idInspeccion) : super(idInspeccion: idInspeccion);
}

class RefreshInspecciones extends RemoteInspeccionesEvent {
  const RefreshInspecciones();
}
