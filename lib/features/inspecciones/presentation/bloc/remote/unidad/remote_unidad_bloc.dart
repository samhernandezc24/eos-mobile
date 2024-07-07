import 'package:eos_mobile/core/data/data_source/predictive.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/unidad/remote_create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/unidad/remote_predictive_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/unidad/remote_store_unidad_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part 'remote_unidad_event.dart';
part 'remote_unidad_state.dart';

class RemoteUnidadBloc extends Bloc<RemoteUnidadEvent, RemoteUnidadState> {
  RemoteUnidadBloc(
    this._remoteCreateUnidadUseCase,
    this._remoteStoreUnidadUseCase,
    this._remotePredictiveUnidadUseCase,
  ) : super(RemoteUnidadInit()) {
    on<CreateUnidad>(onCreateUnidad);
    on<StoreUnidad>(onStoreUnidad);
    on<PredictiveUnidades>(onPredictiveUnidades);
  }

  // USE CASES
  final RemoteCreateUnidadUseCase _remoteCreateUnidadUseCase;
  final RemoteStoreUnidadUseCase _remoteStoreUnidadUseCase;
  final RemotePredictiveUnidadUseCase _remotePredictiveUnidadUseCase;

  Future<void> onCreateUnidad(CreateUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadCreateLoading());

    final objDataState = await _remoteCreateUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadCreate(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessageCreate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerExceptionMessageCreate(objDataState.error));
    }
  }

  Future<void> onStoreUnidad(StoreUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadStoreLoading());

    final objDataState = await _remoteStoreUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadStore(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerExceptionMessageStore(objDataState.error));
    }
  }

  Future<void> onPredictiveUnidades(PredictiveUnidades event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadPredictiveLoading());

    final objDataState = await _remotePredictiveUnidadUseCase(params: event.varArgs);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadPredictive(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessagePredictive(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerExceptionMessagePredictive(objDataState.error));
    }
  }
}
