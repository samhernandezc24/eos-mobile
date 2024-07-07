part of 'remote_categoria_item_bloc.dart';

@immutable
abstract class RemoteCategoriaItemState extends Equatable {
  const RemoteCategoriaItemState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteCategoriaItemInit extends RemoteCategoriaItemState {}

/// LIST
class RemoteCategoriaItemLoading extends RemoteCategoriaItemState {}

class RemoteCategoriaItemList extends RemoteCategoriaItemState {
  const RemoteCategoriaItemList(this.objResponse);

  final CategoriaItemListEntity? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteCategoriaItemStoreLoading extends RemoteCategoriaItemState {}

class RemoteCategoriaItemStore extends RemoteCategoriaItemState {
  const RemoteCategoriaItemStore(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE DUPLICATE
class RemoteCategoriaItemStoreDuplicateLoading extends RemoteCategoriaItemState {}

class RemoteCategoriaItemStoreDuplicate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemStoreDuplicate(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// UPDATE
class RemoteCategoriaItemUpdateLoading extends RemoteCategoriaItemState {}

class RemoteCategoriaItemUpdate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemUpdate(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DELETE
class RemoteCategoriaItemDeleteLoading extends RemoteCategoriaItemState {}

class RemoteCategoriaItemDelete extends RemoteCategoriaItemState {
  const RemoteCategoriaItemDelete(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteCategoriaItemServerFailedMessageList extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageList(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaItemServerFailedMessageStore extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageStore(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaItemServerFailedMessageStoreDuplicate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageStoreDuplicate(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaItemServerFailedMessageUpdate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageUpdate(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaItemServerFailedMessageDelete extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerFailedMessageDelete(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

/// SERVER EXCEPTION
class RemoteCategoriaItemServerExceptionMessageList extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerExceptionMessageList(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaItemServerExceptionMessageStore extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerExceptionMessageStore(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaItemServerExceptionMessageStoreDuplicate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerExceptionMessageStoreDuplicate(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaItemServerExceptionMessageUpdate extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerExceptionMessageUpdate(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaItemServerExceptionMessageDelete extends RemoteCategoriaItemState {
  const RemoteCategoriaItemServerExceptionMessageDelete(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
