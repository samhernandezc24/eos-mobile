part of 'remote_categoria_item_bloc.dart';

class RemoteCategoriaItemState extends Equatable {
  const RemoteCategoriaItemState();

  @override
  List<Object?> get props => [];
}

/// LOADING
class RemoteCategoriaItemLoading extends RemoteCategoriaItemState {}

/// LIST
class RemoteCategoriaItemSuccess extends RemoteCategoriaItemState {
  const RemoteCategoriaItemSuccess(this.objResponse);

  final CategoriaItemDataEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteCategoriaItemStoring extends RemoteCategoriaItemState {}

class RemoteCategoriaItemStored extends RemoteCategoriaItemState {
  const RemoteCategoriaItemStored(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE DUPLICATE
class RemoteCategoriaItemStoringDuplicate extends RemoteCategoriaItemState {}

class RemoteCategoriaItemStoredDuplicate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemStoredDuplicate(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// UPDATE
class RemoteCategoriaItemUpdating extends RemoteCategoriaItemState {}

class RemoteCategoriaItemUpdated extends RemoteCategoriaItemState {
  const RemoteCategoriaItemUpdated(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DELETE
class RemoteCategoriaItemDeleting extends RemoteCategoriaItemState {}

class RemoteCategoriaItemDeleted extends RemoteCategoriaItemState {
  const RemoteCategoriaItemDeleted(this.objResponse);

  final ServerResponse? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteCategoriaItemServerFailedMessage extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteCategoriaItemServerFailure extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
