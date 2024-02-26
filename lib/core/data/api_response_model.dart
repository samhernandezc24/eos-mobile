import 'package:eos_mobile/core/data/api_response_entity.dart';

class ApiResponseModel extends ApiResponseEntity {
  const ApiResponseModel({
    bool? session,
    bool? action,
    dynamic result,
    String? title,
    String? message,
    String? code,
  }) : super(
          session:    session,
          action:     action,
          result:     result,
          title:      title,
          message:    message,
          code:       code,
        );

  /// Un constructor de factory necesario para crear una instancia
  /// de [ApiResponseModel] para el mapeo de json.
  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      session:  json['session'] as bool,
      action:   json['action'] as bool,
      result:   json['result'] as dynamic,
      title:    json['title'] as String,
      message:  json['message'] as String,
      code:     json['code'] as String,
    );
  }

  /// `toJson` es la convención para que una clase soporte la
  /// serialización a formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'session':  session,
      'action':   action,
      'result':   result,
      'title':    title,
      'message':  message,
      'code':     code,
    };
  }
}
