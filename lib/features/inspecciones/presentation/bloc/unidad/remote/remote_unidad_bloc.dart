import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/data_source_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/index_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/list_unidad_usecase.dart';
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
    this._listUnidadUseCase,
  ) : super(RemoteUnidadLoading()) {
    on<FetchUnidadInit>(onFetchUnidadInit);
    on<FetchUnidadDataSource>(onFetchUnidadDataSource);
    on<FetchUnidadCreate>(onFetchUnidadCreate);
    on<StoreUnidad>(onStoreUnidad);
    on<ListUnidades>(onListUnidades);
  }

  // Casos de uso
  final IndexUnidadUseCase _indexUnidadUseCase;
  final DataSourceUnidadUseCase _dataSourceUnidadUseCase;
  final CreateUnidadUseCase _createUnidadUseCase;
  final StoreUnidadUseCase _storeUnidadUseCase;
  final ListUnidadUseCase _listUnidadUseCase;

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
    emit(RemoteUnidadStoring());

    final objDataState = await _storeUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadStored(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessageStore(objDataState.errorMessage));
      await onFetchUnidadCreate(FetchUnidadCreate(), emit);
      await onListUnidades(ListUnidades(), emit);
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailureStore(objDataState.serverException));
      await onFetchUnidadCreate(FetchUnidadCreate(), emit);
      await onListUnidades(ListUnidades(), emit);
    }
  }

  Future<void> onListUnidades(ListUnidades event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadListLoading());

    final objDataState = await _listUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadListLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailure(objDataState.serverException));
    }
  }
}
