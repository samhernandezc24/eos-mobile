import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_auth_event.dart';
part 'remote_auth_state.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  RemoteAuthBloc(this._signInUseCase) : super(RemoteAuthInitial()) { on<SignIn>(onSignIn); }

  // CASOS DE USO
  final SignInUseCase _signInUseCase;

  Future<void> onSignIn(SignIn event, Emitter<RemoteAuthState> emit) async {
    emit(RemoteAuthLoading());

    final objDataState = await _signInUseCase(params: event.credentials);

    if (objDataState is DataSuccess) {
      emit(RemoteAuthSuccess(objDataState.data));
    }

    if (objDataState is DataFailed) {
      emit(RemoteAuthServerFailure(objDataState.serverException));
    }
  }
}
