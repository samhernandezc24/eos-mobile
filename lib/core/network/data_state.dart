import 'package:eos_mobile/core/network/errors/exceptions.dart';

abstract class DataState<T> {
  const DataState({this.data, this.error, this.errorMessage});

  final T? data;
  final ServerException? error;
  final String? errorMessage;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(ServerException error) : super(error: error);
}

class DataFailedMessage<T> extends DataState<T> {
  const DataFailedMessage(String errorMessage) : super(errorMessage: errorMessage);
}
