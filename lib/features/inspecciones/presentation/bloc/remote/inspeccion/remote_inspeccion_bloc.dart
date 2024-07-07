import 'package:eos_mobile/core/data/data_source/data_source.dart';

import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion/remote_cancel_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion/remote_create_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion/remote_data_source_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion/remote_index_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion/remote_store_inspeccion_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part 'remote_inspeccion_event.dart';
part 'remote_inspeccion_state.dart';

class RemoteInspeccionBloc extends Bloc<RemoteInspeccionEvent, RemoteInspeccionState> {
  RemoteInspeccionBloc(
    this._remoteIndexInspeccionUseCase,
    this._remoteDataSourceInspeccionUseCase,
    this._remoteCreateInspeccionUseCase,
    this._remoteStoreInspeccionUseCase,
    this._remoteCancelInspeccionUseCase,
  ) : super(RemoteInspeccionInit()) {
    on<IndexInspeccion>(onFetchInspeccionIndex);
    on<DataSourceInspeccion>(onFetchInspeccionDataSource);
    on<CreateInspeccion>(onCreateInspeccion);
    on<StoreInspeccion>(onStoreInspeccion);
    on<CancelInspeccion>(onCancelInspeccion);
  }

  // USE CASES
  final RemoteIndexInspeccionUseCase _remoteIndexInspeccionUseCase;
  final RemoteDataSourceInspeccionUseCase _remoteDataSourceInspeccionUseCase;
  final RemoteCreateInspeccionUseCase _remoteCreateInspeccionUseCase;
  final RemoteStoreInspeccionUseCase _remoteStoreInspeccionUseCase;
  final RemoteCancelInspeccionUseCase _remoteCancelInspeccionUseCase;

  Future<void> onFetchInspeccionIndex(IndexInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionIndexLoading());

    final objDataState = await _remoteIndexInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionIndex(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageIndex(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerExceptionMessageIndex(objDataState.error));
    }
  }

  Future<void> onFetchInspeccionDataSource(DataSourceInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionDataSourceLoading());

    final objDataState = await _remoteDataSourceInspeccionUseCase(params: event.varArgs);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionDataSource(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageDataSource(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerExceptionMessageDataSource(objDataState.error));
    }
  }

  Future<void> onCreateInspeccion(CreateInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionCreateLoading());

    final objDataState = await _remoteCreateInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCreate(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageCreate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerExceptionMessageCreate(objDataState.error));
    }
  }

  Future<void> onStoreInspeccion(StoreInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionStoreLoading());

    final objDataState = await _remoteStoreInspeccionUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionStore(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerExceptionMessageStore(objDataState.error));
    }
  }

  Future<void> onCancelInspeccion(CancelInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionCancelLoading());

    final objDataState = await _remoteCancelInspeccionUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCancel(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageCancel(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerExceptionMessageCancel(objDataState.error));
    }
  }
}
