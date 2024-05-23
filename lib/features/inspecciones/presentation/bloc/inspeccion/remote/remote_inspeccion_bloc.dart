import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_data_source_res_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_index_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/create_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/data_source_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion/index_inspeccion_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_inspeccion_event.dart';
part 'remote_inspeccion_state.dart';

class RemoteInspeccionBloc extends Bloc<RemoteInspeccionEvent, RemoteInspeccionState> {
  RemoteInspeccionBloc(
    this._indexInspeccionUseCase,
    this._dataSourceInspeccionUseCase,
    this._createInspeccionUseCase,
  ) : super(RemoteInspeccionLoading()) {
    on<FetchInspeccionIndex>(onFetchInspeccionIndex);
    on<FetchInspeccionDataSource>(onFetchInspeccionDataSource);
    on<FetchInspeccionCreate>(onFetchInspeccionCreate);
  }

  // Casos de uso
  final IndexInspeccionUseCase _indexInspeccionUseCase;
  final DataSourceInspeccionUseCase _dataSourceInspeccionUseCase;
  final CreateInspeccionUseCase _createInspeccionUseCase;

  Future<void> onFetchInspeccionIndex(FetchInspeccionIndex event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionIndexLoading());

    final objDataState = await _indexInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionIndexLoaded(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageIndex(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerFailureIndex(objDataState.serverException));
    }
  }

  Future<void> onFetchInspeccionDataSource(FetchInspeccionDataSource event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionLoading());

    final objDataState = await _dataSourceInspeccionUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionDataSourceLoaded(objDataState.data));
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
}
