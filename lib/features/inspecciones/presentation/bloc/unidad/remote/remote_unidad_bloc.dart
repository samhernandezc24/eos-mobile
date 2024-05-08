import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_edit_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/data_source_unidad_usecase.dart';
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
  ) : super(RemoteUnidadLoading()) {
    on<FetchUnidadInit>(onFetchUnidadInit);
    on<FetchUnidadDataSource>(onFetchUnidadDataSource);
    on<CreateUnidad>(onCreateUnidad);
    on<StoreUnidad>(onStoreUnidad);
  }

  // Casos de uso
  final IndexUnidadUseCase _indexUnidadUseCase;
  final DataSourceUnidadUseCase _dataSourceUnidadUseCase;
  final CreateUnidadUseCase _createUnidadUseCase;
  final StoreUnidadUseCase _storeUnidadUseCase;
  final EditUnidadUseCase _editUnidadUseCase;
  final UpdateUnidadUseCase _updateUnidadUseCase;

  Future<void> onFetchUnidadInit(FetchUnidadInit event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadLoading());

    final objDataState = await _indexUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadInitialization(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailure(objDataState.serverException));
    }
  }

    Future<void> onFetchUnidadDataSource(FetchUnidadDataSource event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadLoading());

    final objDataState = await _dataSourceUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadDataSourceLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailure(objDataState.serverException));
    }
  }

  Future<void> onCreateUnidad(CreateUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadCreating());

    final objDataState = await _createUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadCreateLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreUnidad(StoreUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadStoring());

    final objDataState = await _storeUnidadUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadStored(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailure(objDataState.serverException));
    }
  }

  // Future<void> onEditUnidad(EditUnidad event, Emitter<RemoteUnidadState> emit) async {
  //   emit(RemoteUnidadEditing());

  //   final objDataState = await _editUnidadUseCase(params: );

  //   if (objDataState is DataSuccess) {
  //     emit(RemoteUnidadCreateSuccess(objDataState.data));
  //   }

  //   if (objDataState is DataFailedMessage) {
  //     emit(RemoteUnidadFailedMessage(objDataState.errorMessage));
  //   }

  //   if (objDataState is DataFailed) {
  //     emit(RemoteUnidadFailure(objDataState.serverException));
  //   }
  // }

  // Future<void> onStoreUnidad(StoreUnidad event, Emitter<RemoteUnidadState> emit) async {
  //   emit(RemoteUnidadLoading());

  //   final objDataState = await _storeUnidadUseCase(params: event.unidad);

  //   if (objDataState is DataSuccess) {
  //     emit(RemoteUnidadResponseSuccess(objDataState.data!));

  //     emit(RemoteUnidadLoading());
  //   }

  //   if (objDataState is DataFailedMessage) {
  //     emit(RemoteUnidadFailedMessage(objDataState.errorMessage));
  //   }

  //   if (objDataState is DataFailed) {
  //     emit(RemoteUnidadFailure(objDataState.serverException));
  //   }
  // }
}
