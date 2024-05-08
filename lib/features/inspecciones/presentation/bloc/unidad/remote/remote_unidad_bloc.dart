import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_edit_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/data_source_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/delete_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/edit_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/index_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/store_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/update_unidad_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_unidad_event.dart';
part 'remote_unidad_state.dart';

class RemoteUnidadBloc extends Bloc<RemoteUnidadEvent, RemoteUnidadState> {
  RemoteUnidadBloc(
    this._indexUnidadUseCase,
    this._dataSourceUnidadUseCase,
    this._createUnidadUseCase,
    this._storeUnidadUseCase,
    this._editUnidadUseCase,
    this._updateUnidadUseCase,
    this._deleteUnidadUseCase,
  ) : super(RemoteUnidadLoading()) {
    on<FetchUnidadInit>(onFetchUnidadInit);
    on<FetchUnidadDataSource>(onFetchUnidadDataSource);
    on<CreateUnidad>(onCreateUnidad);
    on<StoreUnidad>(onStoreUnidad);
    on<EditUnidad>(onEditUnidad);
    on<UpdateUnidad>(onUpdateUnidad);
  }

  // Casos de uso
  final IndexUnidadUseCase _indexUnidadUseCase;
  final DataSourceUnidadUseCase _dataSourceUnidadUseCase;
  final CreateUnidadUseCase _createUnidadUseCase;
  final StoreUnidadUseCase _storeUnidadUseCase;
  final EditUnidadUseCase _editUnidadUseCase;
  final UpdateUnidadUseCase _updateUnidadUseCase;
  final DeleteUnidadUseCase _deleteUnidadUseCase;

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

  Future<void> onCreateUnidad(CreateUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadCreating());

    final objDataState = await _createUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadCreateLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreUnidad(StoreUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadStoring());

    final objDataState = await _storeUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadStored(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailure(objDataState.serverException));
    }
  }

  Future<void> onEditUnidad(EditUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadEditing());

    final objDataState = await _editUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadEditLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailure(objDataState.serverException));
    }
  }

  Future<void> onUpdateUnidad(UpdateUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadUpdating());

    final objDataState = await _updateUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadUpdated(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailure(objDataState.serverException));
    }
  }

  Future<void> onDeleteUnidad(DeleteUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadDeleting());

    final objDataState = await _deleteUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadDeleted(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadServerFailure(objDataState.serverException));
    }
  }
}
