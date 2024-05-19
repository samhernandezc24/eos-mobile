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

// /// UPDATE
// class RemoteCategoriaItemUpdating extends RemoteCategoriaItemState {}

// class RemoteCategoriaItemUpdated extends RemoteCategoriaItemState {
//   const RemoteCategoriaItemUpdated(this.objResponse);

//   final ServerResponse? objResponse;

//   @override
//   List<Object?> get props => [ objResponse ];
// }

// /// DELETE
// class RemoteCategoriaItemDeleting extends RemoteCategoriaItemState {}

// class RemoteCategoriaItemDeleted extends RemoteCategoriaItemState {
//   const RemoteCategoriaItemDeleted(this.objResponse);

//   final ServerResponse? objResponse;

//   @override
//   List<Object?> get props => [ objResponse ];
// }

/// SERVER FAILED MESSAGE
class RemoteCategoriaItemServerFailedMessageList extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageList(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteCategoriaItemServerFailedMessageStore extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageStore(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteCategoriaItemServerFailedMessageDuplicate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageDuplicate(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteCategoriaItemServerFailedMessageUpdate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageUpdate(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

class RemoteCategoriaItemServerFailedMessageDelete extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageDelete(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteCategoriaItemServerFailureList extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailureList(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteCategoriaItemServerFailureStore extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailureStore(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteCategoriaItemServerFailureDuplicate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailureDuplicate(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteCategoriaItemServerFailureUpdate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailureUpdate(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

class RemoteCategoriaItemServerFailureDelete extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailureDelete(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}
