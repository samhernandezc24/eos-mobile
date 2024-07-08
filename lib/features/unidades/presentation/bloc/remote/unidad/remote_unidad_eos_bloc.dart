import 'package:eos_mobile/features/unidades/domain/entities/unidad/unidad_eos_predictive_entity.dart';
import 'package:eos_mobile/features/unidades/domain/usecases/unidad/remote/remote_predictive_eos_unidad_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

part 'remote_unidad_eos_event.dart';
part 'remote_unidad_eos_state.dart';

class RemoteUnidadEOSBloc extends Bloc<RemoteUnidadEOSEvent, RemoteUnidadEOSState> {
  RemoteUnidadEOSBloc(
    this._remotePredictiveEOSUnidadUseCase,
  ) : super(RemoteUnidadEOSInit()) {
    on<PredictiveUnidadesEOS>(onPredictiveUnidadesEOS);
  }

  // USE CASES
  final RemotePredictiveEOSUnidadUseCase _remotePredictiveEOSUnidadUseCase;

  Future<void> onPredictiveUnidadesEOS(PredictiveUnidadesEOS event, Emitter<RemoteUnidadEOSState> emit) async {
    emit(RemoteUnidadEOSPredictiveLoading());

    final objDataState = await _remotePredictiveEOSUnidadUseCase(params: event.varArgs);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadEOSPredictive(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadEOSServerFailedMessagePredictive(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadEOSServerExceptionMessagePredictive(objDataState.error));
    }
  }
}
