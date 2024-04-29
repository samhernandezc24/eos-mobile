import 'package:eos_mobile/core/data/catalogos_data/unidad_data.dart';
import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/predictive_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/store_unidad_usecase.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_unidad_event.dart';
part 'remote_unidad_state.dart';

class RemoteUnidadBloc extends Bloc<RemoteUnidadEvent, RemoteUnidadState> {
  RemoteUnidadBloc(
    this._createUnidadUseCase,
    this._storeUnidadUseCase,
    this._predictiveUnidadUseCase,
  ) : super(RemoteUnidadLoading()) {
    on<CreateUnidad>(onCreateUnidad);
    on<StoreUnidad>(onStoreUnidad);
    on<PredictiveUnidad>(onPredictiveUnidad);
  }

  // Casos de uso
  final CreateUnidadUseCase _createUnidadUseCase;
  final StoreUnidadUseCase _storeUnidadUseCase;
  final PredictiveUnidadUseCase _predictiveUnidadUseCase;

  Future<void> onCreateUnidad(CreateUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadLoading());

    final objDataState = await _createUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadCreateSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreUnidad(StoreUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadLoading());

    final objDataState = await _storeUnidadUseCase(params: event.unidad);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadResponseSuccess(objDataState.data!));

      emit(RemoteUnidadLoading());
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadFailure(objDataState.serverException));
    }
  }

  Future<void> onPredictiveUnidad(PredictiveUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadLoading());

    final objDataState = await _predictiveUnidadUseCase(params: event.predictiveSearch);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadFailure(objDataState.serverException));
    }
  }
}
