import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_event.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/sign_in/remote/remote_sign_in_state.dart';
import 'package:eos_mobile/shared/shared.dart';

class RemoteSignInBloc extends Bloc<RemoteSignInEvent, RemoteSignInState> {
  RemoteSignInBloc(this._signInUseCase) : super(const RemoteSignInLoading()) {
    on<SignIn> (onSignIn);
  }

  final SignInUseCase _signInUseCase;

  Future<void> onSignIn(SignIn event, Emitter<RemoteSignInState> emit) async {
    final dataState = await _signInUseCase(params: event.credentials);

    if (dataState is DataSuccess) {
      print(dataState.data);
      emit(RemoteSignInSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.exception!.message);
      emit(RemoteSignInFailure(dataState.exception!));
    }
  }
}
