import 'package:eos_mobile/core/data/predictive.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_predictive_list_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/data_source_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/index_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/predictive_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/store_unidad_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_unidad_event.dart';
part 'remote_unidad_state.dart';

class RemoteUnidadBloc extends Bloc<RemoteUnidadEvent, RemoteUnidadState> {
  RemoteUnidadBloc(
    this._indexUnidadUseCase,
    this._dataSourceUnidadUseCase,
    this._createUnidadUseCase,
    this._storeUnidadUseCase,
    this._predictiveUnidadUseCase,
  ) : super(RemoteUnidadInitialState()) {
    on<FetchUnidadInit>(onFetchUnidadInit);
    on<FetchUnidadDataSource>(onFetchUnidadDataSource);
    on<FetchUnidadCreate>(onFetchUnidadCreate);
    on<StoreUnidad>(onStoreUnidad);
    on<PredictiveUnidades>(onPredictiveUnidades);
  }

  // CASOS DE USO
  final IndexUnidadUseCase _indexUnidadUseCase;
  final DataSourceUnidadUseCase _dataSourceUnidadUseCase;
  final CreateUnidadUseCase _createUnidadUseCase;
  final StoreUnidadUseCase _storeUnidadUseCase;
  final PredictiveUnidadUseCase _predictiveUnidadUseCase;

  Future<void> onFetchUnidadInit(FetchUnidadInit event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadLoading());

    final objDataState = await _indexUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadInitialization(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailure(objDataState.serverException));
    }
  }

  Future<void> onFetchUnidadDataSource(FetchUnidadDataSource event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadLoading());

    final objDataState = await _dataSourceUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadDataSourceLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailure(objDataState.serverException));
    }
  }

  Future<void> onFetchUnidadCreate(FetchUnidadCreate event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadCreateLoading());

    final objDataState = await _createUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadCreateLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessageCreate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailureCreate(objDataState.serverException));
    }
  }

  Future<void> onStoreUnidad(StoreUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadStoreLoading());

    final objDataState = await _storeUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadStoreSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailureStore(objDataState.serverException));
    }
  }

  Future<void> onPredictiveUnidades(PredictiveUnidades event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadPredictiveLoading());

    final objDataState = await _predictiveUnidadUseCase(params: event.varArgs);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadPredictiveLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessagePredictive(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailurePredictive(objDataState.serverException));
    }
  }
}
