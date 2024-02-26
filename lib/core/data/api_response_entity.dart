import 'package:eos_mobile/shared/shared.dart';

class ApiResponseEntity extends Equatable {
  const ApiResponseEntity({
    this.session,
    this.action,
    this.result,
    this.title,
    this.message,
    this.code,
  });

  final bool? session;
  final bool? action;
  final dynamic result;
  final String? title;
  final String? message;
  final String? code;

  @override
  List<Object?> get props => [
        session,
        action,
        result,
        title,
        message,
        code,
      ];
}
