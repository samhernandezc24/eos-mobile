part of 'remote_categoria_bloc.dart';

class RemoteCategoriaState extends Equatable {
  const RemoteCategoriaState();

  @override
  List<Object?> get props => [];
}

class RemoteCategoriaLoading extends RemoteCategoriaState {}

class RemoteCategoriaSuccess extends RemoteCategoriaState {
  const RemoteCategoriaSuccess(this.categorias);

  final List<CategoriaEntity>? categorias;

  @override
  List<Object?> get props => [ categorias ];
}

class RemoteCategoriaResponseSuccess extends RemoteCategoriaState {
  const RemoteCategoriaResponseSuccess(this.apiResponse);

  final ServerResponse apiResponse;

  @override
  List<Object?> get props => [ apiResponse ];
}

/// SERVER FAILED MESSAGE
class RemoteCategoriaServerFailedMessage extends RemoteCategoriaState {
  const RemoteCategoriaServerFailedMessage(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object?> get props => [ errorMessage ];
}

/// SERVER FAILURE
class RemoteCategoriaServerFailure extends RemoteCategoriaState {
  const RemoteCategoriaServerFailure(this.failure);

  final ServerException? failure;

  @override
  List<Object?> get props => [ failure ];
}

// part of 'remote_categoria_bloc.dart';

// class RemoteCategoriaState extends Equatable {
//   const RemoteCategoriaState();

//   @override
//   List<Object?> get props => [];
// }

// /// LOADING
// class RemoteCategoriaLoading extends RemoteCategoriaState {}

// /// INIT
// class RemoteCategoriaSuccess extends RemoteCategoriaState {
//   const RemoteCategoriaSuccess(this.categorias);

//   final List<CategoriaEntity>? categorias;

//   @override
//   List<Object?> get props => [ categorias ];
// }

// /// STORE
// class RemoteCategoriaStoring extends RemoteCategoriaState {}

// class RemoteCategoriaStored extends RemoteCategoriaState {
//   const RemoteCategoriaStored(this.objResponse);

//   final ServerResponse? objResponse;

//   @override
//   List<Object?> get props => [ objResponse ];
// }

// /// UPDATE
// class RemoteCategoriaUpdating extends RemoteCategoriaState {}

// class RemoteCategoriaUpdated extends RemoteCategoriaState {
//   const RemoteCategoriaUpdated(this.objResponse);

//   final ServerResponse? objResponse;

//   @override
//   List<Object?> get props => [ objResponse ];
// }

// /// DELETE
// class RemoteCategoriaDeleting extends RemoteCategoriaState {}

// class RemoteCategoriaDeleted extends RemoteCategoriaState {
//   const RemoteCategoriaDeleted(this.objResponse);

//   final ServerResponse? objResponse;

//   @override
//   List<Object?> get props => [ objResponse ];
// }
