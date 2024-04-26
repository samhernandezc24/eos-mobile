import 'package:eos_mobile/shared/shared_libraries.dart';

class ServerException implements Exception {
  ServerException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Se agotó el tiempo de conexión con el servidor.';
      case DioExceptionType.sendTimeout:
        errorMessage = 'Se agotó el tiempo de envío.';
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Se agotó el tiempo de recepción.';
      case DioExceptionType.badCertificate:
        errorMessage = 'Certificado inválido.';
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioException.response?.statusCode, dioException.response?.data.toString());
      case DioExceptionType.cancel:
        errorMessage = 'La solicitud al servidor ha sido cancelada.';
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          errorMessage = 'No hay conexión a internet.';
        }
        errorMessage = 'Se produjo un error inesperado. Inténtalo de nuevo.';
    }
  }

  late String errorMessage;

  String _handleStatusCode(int? statusCode, String? serverMessage) {
    switch (statusCode) {
      case 400:
        if (serverMessage != null && serverMessage.isNotEmpty) {
          return serverMessage;
        } else {
          return 'Error $statusCode: El servidor no puede procesar la solicitud debido a un error en el cliente.';
        }
      case 401:
        return 'Error $statusCode: El cliente debe autenticarse para obtener la respuesta solicitada.';
      case 403:
        return 'Error $statusCode: El servidor ha entendido la solicitud, pero se niega a autorizarla.';
      case 404:
        return 'Error $statusCode: El servidor no pudo encontrar el recurso solicitado.';
      case 500:
        return 'Error $statusCode: El servidor encontró una situación con la que no sabe cómo lidiar.';
      case 502:
        return 'Error $statusCode: El servidor recibió una respuesta no válida desde el servidor ascendente al intentar cumplir la solicitud.';
      default:
        return 'Error de servidor con código: $statusCode.';
    }
  }

  @override
  String toString() => errorMessage;
}

class LocalException implements Exception {
  const LocalException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;
}
