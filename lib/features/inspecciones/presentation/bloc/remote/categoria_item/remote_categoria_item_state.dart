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
