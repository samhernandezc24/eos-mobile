class ServerException implements Exception {
  const ServerException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;
}

class LocalException implements Exception {
  const LocalException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;
}
