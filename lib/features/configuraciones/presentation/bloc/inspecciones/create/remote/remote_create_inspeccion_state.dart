import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteCreateInspeccionState extends Equatable {
  const RemoteCreateInspeccionState({this.message, this.failure});

  final String? message;
  final DioException? failure;

  @override
  List<Object?> get props => [message, failure];
}

class RemoteCreateInspeccionLoading extends RemoteCreateInspeccionState {
  const RemoteCreateInspeccionLoading();
}

class RemoteCreateInspeccionDone extends RemoteCreateInspeccionState {
  const RemoteCreateInspeccionDone(String message) : super(message: message);
}

class RemoteCreateInspeccionFailure extends RemoteCreateInspeccionState {
  const RemoteCreateInspeccionFailure(DioException failure) : super(failure: failure);
}
