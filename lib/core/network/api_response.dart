import 'package:eos_mobile/shared/shared.dart';

class ApiResponse extends ApiResponseEntity {
  const ApiResponse({
    required bool session,
    required bool action,
    required Map<String, dynamic> result,
    required String title,
    required String message,
    required String code,
  }) : super(
          session  : session,
          action   : action,
          result   : result,
          title    : title,
          message  : message,
          code     : code,
        );

  /// Constructor factory para crear la instancia de [ApiResponse]
  /// durante el mapeo del JSON.
  factory ApiResponse.fromJson(Map<String, dynamic> jsonMap) {
    return ApiResponse(
      session   : jsonMap['session'] as bool,
      action    : jsonMap['action'] as bool,
      result    : jsonMap['result'] as Map<String, dynamic>,
      title     : jsonMap['title'] as String,
      message   : jsonMap['message'] as String,
      code      : jsonMap['code'] as String,
    );
  }

  /// Serialización de la estructura del modelo a formato JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
    'session'  : session,
    'action'   : action,
    'result'   : result,
    'title'    : title,
    'message'  : message,
    'code'     : code,
    };
  }
}

@immutable
class ApiResponseEntity extends Equatable {
  const ApiResponseEntity({
    required this.session,
    required this.action,
    required this.result,
    required this.title,
    required this.message,
    required this.code,
  });

  final bool session;
  final bool action;
  final Map<String, dynamic> result;
  final String title;
  final String message;
  final String code;

  @override
  List<Object?> get props => [ session, action, result, title, message, code ];
}
