import 'package:eos_mobile/shared/shared.dart';

abstract class DataState<T> {
  const DataState({this.data, this.exception, this.errorMessage});

  final T? data;
  final DioException? exception;
  final String? errorMessage;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailedMessage<T> extends DataState<T> {
  const DataFailedMessage(String message) : super(errorMessage: message);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException exception) : super(exception: exception);
}
