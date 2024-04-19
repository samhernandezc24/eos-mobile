import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/dio_exception.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_auth_event.dart';
part 'remote_auth_state.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  RemoteAuthBloc(this._signInUseCase) : super(RemoteAuthInitial()) {
    on<SignInSubmitted>(onSignInSubmitted);
  }

  // Casos de uso
  final SignInUseCase _signInUseCase;

  Future<void> onSignInSubmitted(SignInSubmitted event, Emitter<RemoteAuthState> emit) async {
    emit(RemoteSignInLoading());

    final objDataState = await _signInUseCase(params: event.signIn);

    if (objDataState is DataSuccess) {
      emit(RemoteSignInSuccess(objDataState.data));
    }

    if (objDataState is DataFailed) {
      emit(RemoteSignInFailure(objDataState.serverException));
    }
  }
}
