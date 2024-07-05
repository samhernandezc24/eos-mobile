import 'package:dio/dio.dart';
import 'package:eos_mobile/core/constants/sessions.dart';

/// Clase que contiene la lógica de intercepción para las solicitudes
/// relacionados con APIs. Este es el primer interceptor en caso tanto
/// de solicitudes como de respuestas.
///
/// El propósito principal es manejar la inyección de tokens y la validación
/// del éxito de la respuesta.
///
/// Dado que este interceptor no es responsable de la gestión de errores, si se produce
/// una excepción se pasa al siguiente [Interceptor] o a [Dio].
class ApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await Sessions.header().then((headers) {
      options.headers.addAll(headers);
      handler.next(options);
    });
  }
}
