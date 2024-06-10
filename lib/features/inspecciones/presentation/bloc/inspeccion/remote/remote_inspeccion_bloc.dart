import 'package:eos_mobile/core/data/data_source.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/cancel_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/create_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/data_source_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/index_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/store_inspeccion_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_inspeccion_event.dart';
part 'remote_inspeccion_state.dart';

class RemoteInspeccionBloc extends Bloc<RemoteInspeccionEvent, RemoteInspeccionState> {
  RemoteInspeccionBloc(
    this._indexInspeccionUseCase,
    this._dataSourceInspeccionUseCase,
    this._createInspeccionUseCase,
    this._storeInspeccionUseCase,
    this._cancelInspeccionUseCase,
  ) : super(RemoteInspeccionInitial()) {
    on<FetchInspeccionIndex>(onFetchInspeccionIndex);
    on<FetchInspeccionDataSource>(onFetchInspeccionDataSource);
    on<FetchInspeccionCreate>(onFetchInspeccionCreate);
    on<StoreInspeccion>(onStoreInspeccion);
    on<CancelInspeccion>(onCancelInspeccion);
  }

  // Casos de uso
  final IndexInspeccionUseCase _indexInspeccionUseCase;
  final DataSourceInspeccionUseCase _dataSourceInspeccionUseCase;
  final CreateInspeccionUseCase _createInspeccionUseCase;
  final StoreInspeccionUseCase _storeInspeccionUseCase;
  final CancelInspeccionUseCase _cancelInspeccionUseCase;

  Future<void> onFetchInspeccionIndex(FetchInspeccionIndex event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionIndexLoading());

    final objDataState = await _indexInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionIndexSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageIndex(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailureIndex(objDataState.serverException));
    }
  }

  Future<void> onFetchInspeccionDataSource(FetchInspeccionDataSource event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionDataSourceLoading());

    final objDataState = await _dataSourceInspeccionUseCase(params: event.varArgs);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionDataSourceSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageDataSource(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailureDataSource(objDataState.serverException));
    }
  }

  Future<void> onFetchInspeccionCreate(FetchInspeccionCreate event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionCreateLoading());

    final objDataState = await _createInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCreateLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageCreate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailureCreate(objDataState.serverException));
    }
  }

  Future<void> onStoreInspeccion(StoreInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionStoreLoading());

    final objDataState = await _storeInspeccionUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionStoreSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageStore(objDataState.errorMessage));
      await onFetchInspeccionCreate(FetchInspeccionCreate(), emit);
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailureStore(objDataState.serverException));
      await onFetchInspeccionCreate(FetchInspeccionCreate(), emit);
    }
  }

  Future<void> onCancelInspeccion(CancelInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionCanceling());

    final objDataState = await _cancelInspeccionUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCanceledSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageCancel(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailureCancel(objDataState.serverException));
    }
  }
}
