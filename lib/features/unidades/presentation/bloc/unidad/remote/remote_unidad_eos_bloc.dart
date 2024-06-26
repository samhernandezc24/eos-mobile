import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/unidades/domain/entities/unidad/unidad_eos_predictive_list_entity.dart';
import 'package:eos_mobile/features/unidades/domain/usecases/unidad/predictive_eos_unidad_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_unidad_eos_event.dart';
part 'remote_unidad_eos_state.dart';

class RemoteUnidadEOSBloc extends Bloc<RemoteUnidadEOSEvent, RemoteUnidadEOSState> {
  RemoteUnidadEOSBloc(this._predictiveEOSUnidadUseCase) : super(RemoteUnidadEOSInitialState()) {
    on<PredictiveEOSUnidades>(onPredictiveEOSUnidades);
  }

  // CASOS DE USO
  final PredictiveEOSUnidadUseCase _predictiveEOSUnidadUseCase;

  Future<void> onPredictiveEOSUnidades(PredictiveEOSUnidades event, Emitter<RemoteUnidadEOSState> emit) async {
    emit(RemoteUnidadEOSPredictiveLoading());

    final objDataState = await _predictiveEOSUnidadUseCase(params: event.varArgs);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadEOSPredictiveLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadEOSServerFailedMessagePredictive(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadEOSServerFailurePredictive(objDataState.serverException));
    }
  }
}
