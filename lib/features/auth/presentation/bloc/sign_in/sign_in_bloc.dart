import 'package:eos_mobile/config/logic/common/auth_token_storage.dart';
import 'package:eos_mobile/config/logic/common/user_info_storage.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/auth/data/models/user_model.dart';
import 'package:eos_mobile/features/auth/domain/entities/account_entity.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._signInUseCase) : super(SignInInitial()) {
    on<SignInSubmitted>(_onSubmitted);
  }

  final SignInUseCase _signInUseCase;

  Future<void> _onSubmitted(SignInSubmitted event, Emitter<SignInState> emit) async {
    emit(SignInLoading());

    final dataState = await _signInUseCase(event.signIn);

    if (dataState is DataSuccess) {
      // Guardar el token de autenticación en local para recordar la sesión del usuario.
      await AuthTokenStorage.saveAuthToken(dataState.data!.token);

      // Guardar la información del usuario en local.
      await _saveUserDataToLocal(dataState.data!);

      emit(SignInSuccess(dataState.data));
    }

    if (dataState is DataFailed) {
      emit(SignInFailure(dataState.exception));
    }
  }

  Future<void> _saveUserDataToLocal(AccountEntity account) async {
    await UserInfoStorage.saveUserInfo(
      id          : account.id,
      user        : UserModel.fromEntity(account.user),
      privilegies : account.privilegies,
      expiration  : account.expiration,
      foto        : account.foto,
      nombre      : account.nombre,
      userKey     : account.key,
    );
  }
}
