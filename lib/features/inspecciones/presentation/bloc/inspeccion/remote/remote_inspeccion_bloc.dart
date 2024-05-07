import 'package:eos_mobile/core/network/data/server_response.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
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
    this._createInspeccionUseCase,
    this._storeInspeccionUseCase,
    this._dataSourceInspeccionUseCase,
  ) : super(RemoteInspeccionLoading()) {
    on<FetchInspeccionInit>(onFetchInspeccionInit);
    on<CreateInspeccionData>(onCreateInspeccion);
    on<StoreInspeccion>(onStoreInspeccion);
    on<DataSourceInspeccion>(onDataSourceInspeccion);
  }

  // Casos de uso
  final IndexInspeccionUseCase _indexInspeccionUseCase;
  final CreateInspeccionUseCase _createInspeccionUseCase;
  final StoreInspeccionUseCase _storeInspeccionUseCase;
  final DataSourceInspeccionUseCase _dataSourceInspeccionUseCase;

  Future<void> onFetchInspeccionInit(FetchInspeccionInit event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionLoading());

    final objDataState = await _indexInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionInitialization(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFailure(objDataState.serverException));
    }
  }

  Future<void> onCreateInspeccion(CreateInspeccionData event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionLoading());

    final objDataState = await _createInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCreateSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreInspeccion(StoreInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionLoading());

    final objDataState = await _storeInspeccionUseCase(params: event.inspeccion);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionResponseSuccess(objDataState.data!));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFailure(objDataState.serverException));
    }
  }

  Future<void> onDataSourceInspeccion(DataSourceInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionLoading());

    final objDataState = await _dataSourceInspeccionUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionDataSourceSuccess(objDataState.data!));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFailure(objDataState.serverException));
    }
  }
}
