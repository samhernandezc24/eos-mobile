import 'package:eos_mobile/core/data/api_response_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteCreateInspeccionState extends Equatable {
  const RemoteCreateInspeccionState({this.response, this.failure});

  final ApiResponseEntity? response;
  final DioException? failure;

  @override
  List<Object?> get props => [response, failure];
}

class RemoteCreateInspeccionInitial extends RemoteCreateInspeccionState {
  const RemoteCreateInspeccionInitial();
}

class RemoteCreateInspeccionLoading extends RemoteCreateInspeccionState {
  const RemoteCreateInspeccionLoading();
}

class RemoteCreateInspeccionDone extends RemoteCreateInspeccionState {
  const RemoteCreateInspeccionDone(ApiResponseEntity response) : super(response: response);
}

class RemoteCreateInspeccionFailure extends RemoteCreateInspeccionState {
  const RemoteCreateInspeccionFailure(DioException failure) : super(failure: failure);
}
