import 'package:eos_mobile/shared/shared_libs.dart';

class ServerException implements Exception {
  ServerException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = AppStrings.errorConnectionTimeoutMessage;
      case DioExceptionType.sendTimeout:
        errorMessage = AppStrings.errorSendTimeoutMessage;
      case DioExceptionType.receiveTimeout:
        errorMessage = AppStrings.errorReceiveTimeoutMessage;
      case DioExceptionType.badCertificate:
        errorMessage = AppStrings.errorBadCertificateMessage;
      case DioExceptionType.badResponse:
        errorMessage = _badResponseExceptionMessage(dioException.response?.statusCode, dioException.response?.data.toString());
      case DioExceptionType.cancel:
        errorMessage = AppStrings.errorServerCancelMessage;
      case DioExceptionType.connectionError:
        errorMessage = AppStrings.errorConnectionMessage;
      case DioExceptionType.unknown:
        errorMessage = AppStrings.errorUnknownMessage;
    }
  }

  late String errorMessage;

  String _badResponseExceptionMessage(int? statusCode, String? serverResponse) {
    if (statusCode == null) { return AppStrings.errorGenericMessage; }

    if (serverResponse != null && serverResponse.isNotEmpty) { return serverResponse; }

    final String message;

    if (statusCode >= 100 && statusCode < 200) {
      message = AppStrings.errorBadResponseInfoMessage.replaceFirst('{statusCode}', statusCode.toString());
    } else if (statusCode >= 200 && statusCode < 300) {
      message = AppStrings.errorBadResponseSuccessMessage.replaceFirst('{statusCode}', statusCode.toString());
    } else if (statusCode >= 300 && statusCode < 400) {
      message = AppStrings.errorBadResponseRedirectMessage.replaceFirst('{statusCode}', statusCode.toString());
    } else if (statusCode >= 400 && statusCode < 500) {
      message = AppStrings.errorBadResponseClientErrorMessage.replaceFirst('{statusCode}', statusCode.toString());
    } else if (statusCode >= 500 && statusCode < 600) {
      message = AppStrings.errorBadResponseServerErrorMessage.replaceFirst('{statusCode}', statusCode.toString());
    } else {
      message = AppStrings.errorBadResponseUnknownMessage;
    }

    return message;
  }

  @override
  String toString() => errorMessage;
}
