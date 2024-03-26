import 'package:eos_mobile/core/enums/auth_status.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._signOutUseCase) : super(const AuthenticationState.unknown()) {
    on<AuthenticationSignOutRequested>(_onAuthenticationSignOutRequested);
  }

  final SignOutUseCase _signOutUseCase;

  void _onAuthenticationSignOutRequested(AuthenticationSignOutRequested event, Emitter<AuthenticationState> emit) {
    _signOutUseCase(NoParams());
    emit(const AuthenticationState.unauthenticated());
  }
}
