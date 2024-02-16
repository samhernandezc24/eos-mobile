import 'package:eos_mobile/core/resources/data_state.dart';
import 'package:eos_mobile/features/auth/data/models/login_model.dart';
import 'package:eos_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/login/remote/remote_login_event.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/login/remote/remote_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteLoginBloc extends Bloc<RemoteLoginEvent, RemoteLoginState> {
  RemoteLoginBloc(this._loginUseCase) : super(const RemoteLoginLoading());

  final LoginUseCase _loginUseCase;

  Stream<RemoteLoginState> mapEventToState(RemoteLoginEvent event) async* {
    if (event is LoginStarted) {
      yield* _mapLoginStartedToState(event);
    }
  }

  Stream<RemoteLoginState> _mapLoginStartedToState(LoginStarted event) async* {
    yield const RemoteLoginLoading();

    final result = await _loginUseCase.call(
        params: LoginModel(email: event.email, password: event.password));

    if (result is DataSuccess) {
      yield RemoteLoginDone(result.data!);
    }

    if (result is DataFailed) {
      print(result.error!.message);
      yield RemoteLoginFailure(result.error!);
    }
  }
}
