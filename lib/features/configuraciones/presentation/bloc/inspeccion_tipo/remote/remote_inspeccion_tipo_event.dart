part of 'remote_inspeccion_tipo_bloc.dart';

sealed class RemoteInspeccionTipoEvent extends Equatable {
  const RemoteInspeccionTipoEvent();

  @override
  List<Object?> get props => [];
}

class FetcInspeccionesTipos extends RemoteInspeccionTipoEvent { }

class CreateInspeccionTipo extends RemoteInspeccionTipoEvent {
  const CreateInspeccionTipo(this.inspeccionTipoReq);

  final InspeccionTipoReqEntity inspeccionTipoReq;

  @override
  List<Object?> get props => [ inspeccionTipoReq ];
}

class UpdateInspeccionTipo extends RemoteInspeccionTipoEvent {
  const UpdateInspeccionTipo(this.inspeccionTipoReq);

  final InspeccionTipoReqEntity inspeccionTipoReq;

  @override
  List<Object?> get props => [ inspeccionTipoReq ];
}

class DeleteInspeccionTipo extends RemoteInspeccionTipoEvent {
  const DeleteInspeccionTipo(this.inspeccionTipoReq);

  final InspeccionTipoReqEntity inspeccionTipoReq;

  @override
  List<Object?> get props => [ inspeccionTipoReq ];
}
