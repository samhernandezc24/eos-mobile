part of 'remote_unidad_bloc.dart';

sealed class RemoteUnidadEvent extends Equatable {
  const RemoteUnidadEvent();

  @override
  List<Object?> get props => [];
}

/// [IndexUnidadUseCase]
class FetchUnidadInit extends RemoteUnidadEvent {}

/// [DataSourceUnidadUseCase]
class FetchUnidadDataSource extends RemoteUnidadEvent {
  const FetchUnidadDataSource(this.objData);

  final Map<String, dynamic> objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [CreateUnidadUseCase]
class CreateUnidad extends RemoteUnidadEvent {}

/// [StoreUnidadUseCase]
class StoreUnidad extends RemoteUnidadEvent {
  const StoreUnidad(this.objData);

  final UnidadStoreReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [EditUnidadUseCase]
class EditUnidad extends RemoteUnidadEvent {
  const EditUnidad(this.objData);

  final UnidadEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [UpdateUnidadUseCase]
class UpdateUnidad extends RemoteUnidadEvent {
  const UpdateUnidad(this.objData);

  final UnidadUpdateReqEntity objData;

  @override
  List<Object?> get props => [ objData ];
}

/// [DeleteUnidadUseCase]
class DeleteUnidad extends RemoteUnidadEvent {
  const DeleteUnidad(this.objData);

  final UnidadEntity objData;

  @override
  List<Object?> get props => [ objData ];
}
