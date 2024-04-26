import 'dart:io';

import 'package:eos_mobile/core/network/dio_connectivity_request_retrier.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  final DioConnectivityRequestRetrier requestRetrier;

  @override
  Future<dynamic> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        // Reintentar la solicitud.
        return await requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        // Deja pasar cualquier nuevo error del retrier.
        return e;
      }
    }
    // Dejar pasar el error si no es el que buscamos.
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.badResponse && err.error != null && err.error is SocketException;
  }
}
