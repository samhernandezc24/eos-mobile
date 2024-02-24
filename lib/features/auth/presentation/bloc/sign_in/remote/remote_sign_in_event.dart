import 'package:eos_mobile/core/usecases/params.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteSignInEvent extends Equatable {
  const RemoteSignInEvent({this.credentials});

  final SignInParams? credentials;

  @override
  List<Object> get props => [credentials!];
}

class SignIn extends RemoteSignInEvent {
  const SignIn(SignInParams credentials) : super(credentials: credentials);
}
