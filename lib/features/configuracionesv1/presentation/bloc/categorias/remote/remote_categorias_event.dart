import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_req_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteCategoriasEvent extends Equatable {
  const RemoteCategoriasEvent({this.inspeccionId});

  final InspeccionReqEntity? inspeccionId;

  @override
  List<Object?> get props => [inspeccionId];
}

class GetCategorias extends RemoteCategoriasEvent {
  const GetCategorias();
}

class GetCategoriasByIdInspeccion extends RemoteCategoriasEvent {
  const GetCategoriasByIdInspeccion(InspeccionReqEntity inspeccionId) : super(inspeccionId: inspeccionId);
}

class RefreshCategorias extends RemoteCategoriasEvent {
  const RefreshCategorias();
}
