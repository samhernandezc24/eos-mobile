part of 'remote_categoria_bloc.dart';

@immutable
abstract class RemoteCategoriaState extends Equatable {
  const RemoteCategoriaState();

  @override
  List<Object?> get props => [];
}

/// INIT
class RemoteCategoriaInit extends RemoteCategoriaState {}

/// LIST
class RemoteCategoriaLoading extends RemoteCategoriaState {}

class RemoteCategoriaList extends RemoteCategoriaState {
  const RemoteCategoriaList(this.objResponse);

  final List<CategoriaEntity>? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// STORE
class RemoteCategoriaStoreLoading extends RemoteCategoriaState {}

class RemoteCategoriaStore extends RemoteCategoriaState {
  const RemoteCategoriaStore(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// UPDATE
class RemoteCategoriaUpdateLoading extends RemoteCategoriaState {}

class RemoteCategoriaUpdate extends RemoteCategoriaState {
  const RemoteCategoriaUpdate(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// DELETE
class RemoteCategoriaDeleteLoading extends RemoteCategoriaState {}

class RemoteCategoriaDelete extends RemoteCategoriaState {
  const RemoteCategoriaDelete(this.objResponse);

  final IReturn? objResponse;

  @override
  List<Object?> get props => [ objResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteCategoriaServerFailedMessageList extends RemoteCategoriaState {
  const RemoteCategoriaServerFailedMessageList(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaServerFailedMessageStore extends RemoteCategoriaState {
  const RemoteCategoriaServerFailedMessageStore(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaServerFailedMessageUpdate extends RemoteCategoriaState {
  const RemoteCategoriaServerFailedMessageUpdate(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaServerFailedMessageDelete extends RemoteCategoriaState {
  const RemoteCategoriaServerFailedMessageDelete(this.error);

  final String? error;

  @override
  List<Object?> get props => [ error ];
}

/// SERVER EXCEPTION
class RemoteCategoriaServerExceptionMessageList extends RemoteCategoriaState {
  const RemoteCategoriaServerExceptionMessageList(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaServerExceptionMessageStore extends RemoteCategoriaState {
  const RemoteCategoriaServerExceptionMessageStore(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaServerExceptionMessageUpdate extends RemoteCategoriaState {
  const RemoteCategoriaServerExceptionMessageUpdate(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}

class RemoteCategoriaServerExceptionMessageDelete extends RemoteCategoriaState {
  const RemoteCategoriaServerExceptionMessageDelete(this.error);

  final ServerException? error;

  @override
  List<Object?> get props => [ error ];
}
