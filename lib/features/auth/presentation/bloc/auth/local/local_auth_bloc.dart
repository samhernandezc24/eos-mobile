import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/auth/domain/entities/sign_in_entity.dart';
import 'package:eos_mobile/features/auth/domain/usecases/get_saved_credentials_usecase.dart';
import 'package:eos_mobile/features/auth/domain/usecases/save_credentials_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc(this._getSavedCredentialsUseCase, this._saveCredentialsUseCase) : super(LocalAuthInitial()) {
    on<GetSavedCredentials>(onGetSavedCredentials);
    on<SaveCredentials>(onSaveCredentials);
  }

  // Casos de uso
  final SaveCredentialsUseCase _saveCredentialsUseCase;
  final GetSavedCredentialsUseCase _getSavedCredentialsUseCase;

  Future<void> onGetSavedCredentials(GetSavedCredentials event, Emitter<LocalAuthState> emit) async {
    final credentials = await _getSavedCredentialsUseCase(params: NoParams());
    emit(LocalCredentialsSuccess(credentials));
  }

  Future<void> onSaveCredentials(SaveCredentials saveCredentials, Emitter<LocalAuthState> emit) async {
    await _saveCredentialsUseCase(params: saveCredentials.signIn);
    final credentials = await _getSavedCredentialsUseCase(params: NoParams());
    emit(LocalCredentialsSuccess(credentials));
  }
}
