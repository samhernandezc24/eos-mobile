import 'package:eos_mobile/core/network/errors/dio_exception.dart';

abstract class DataState<T> {
  const DataState({this.data, this.serverException, this.errorMessage});

  final T? data;
  final ServerException? serverException;
  final String? errorMessage;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailedMessage<T> extends DataState<T> {
  const DataFailedMessage(String message) : super(errorMessage: message);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(ServerException serverException) : super(serverException: serverException);
}
