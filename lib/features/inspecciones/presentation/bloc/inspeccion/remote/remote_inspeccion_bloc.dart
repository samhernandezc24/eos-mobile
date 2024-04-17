import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/create_inspeccion_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_inspeccion_event.dart';
part 'remote_inspeccion_state.dart';

class RemoteInspeccionBloc extends Bloc<RemoteInspeccionEvent, RemoteInspeccionState> {
  RemoteInspeccionBloc(
    this._createInspeccionUseCase,
  ) : super(RemoteInspeccionLoading()) {
    on<CreateInspeccionData>(onCreateInspeccion);
  }

  // Casos de uso
  final CreateInspeccionUseCase _createInspeccionUseCase;

  Future<void> onCreateInspeccion(CreateInspeccionData event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionLoading());

    final objDataState = await _createInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      print(objDataState.data);
      emit(RemoteInspeccionCreateSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFailure(objDataState.exception));
    }
  }
}
