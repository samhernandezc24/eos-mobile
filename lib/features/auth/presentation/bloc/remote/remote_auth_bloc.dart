import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/usecases/remote/remote_sign_in_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part 'remote_auth_event.dart';
part 'remote_auth_state.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  RemoteAuthBloc(this._remoteSignInUseCase) : super(RemoteAuthInit()) {
    on<SignIn>(onSignIn);
  }

  // USE CASES
  final RemoteSignInUseCase _remoteSignInUseCase;

  Future<void> onSignIn(SignIn event, Emitter<RemoteAuthState> emit) async {
    emit(RemoteAuthLoading());

    final objDataState = await _remoteSignInUseCase(params: event.credentials);

    if (objDataState is DataSuccess) {
      emit(RemoteAuthSuccess(objDataState.data));
    }

    if (objDataState is DataFailed) {
      emit(RemoteAuthServerError(objDataState.error));
    }
  }
}
