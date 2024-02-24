import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/shared/shared.dart';

abstract class RemoteSignInEvent extends Equatable {
  const RemoteSignInEvent({required this.signIn});

  final SignInEntity signIn;

  @override
  List<Object> get props => [signIn];
}

class SignIn extends RemoteSignInEvent {
  const SignIn(SignInEntity signIn) : super(signIn: signIn);
}
