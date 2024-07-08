import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_checklist_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_categoria/remote_get_preguntas_inspeccion_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_categoria/remote_store_inspeccion_categoria_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

part 'remote_inspeccion_categoria_event.dart';
part 'remote_inspeccion_categoria_state.dart';

class RemoteInspeccionCategoriaBloc extends Bloc<RemoteInspeccionCategoriaEvent, RemoteInspeccionCategoriaState> {
  RemoteInspeccionCategoriaBloc(
    this._remoteGetPreguntasInspeccionCategoriaUseCase,
    this._remoteStoreInspeccionCategoriaUseCase,
  ) : super(RemoteInspeccionCategoriaInit()) {
    on<GetPreguntas>(onGetPreguntasInspeccionCategoria);
    on<StoreInspeccionCategoria>(onStoreInspeccionCategoria);
  }

  // USE CASES
  final RemoteGetPreguntasInspeccionCategoriaUseCase _remoteGetPreguntasInspeccionCategoriaUseCase;
  final RemoteStoreInspeccionCategoriaUseCase _remoteStoreInspeccionCategoriaUseCase;

  Future<void> onGetPreguntasInspeccionCategoria(GetPreguntas event, Emitter<RemoteInspeccionCategoriaState> emit) async {
    emit(RemoteInspeccionCategoriaGetPreguntasLoading());

    final objDataState = await _remoteGetPreguntasInspeccionCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCategoriaGetPreguntas(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionCategoriaServerFailedMessageGetPreguntas(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionCategoriaServerExceptionMessageGetPreguntas(objDataState.error));
    }
  }

  Future<void> onStoreInspeccionCategoria(StoreInspeccionCategoria event, Emitter<RemoteInspeccionCategoriaState> emit) async {
    emit(RemoteInspeccionCategoriaStoreLoading());

    final objDataState = await _remoteStoreInspeccionCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCategoriaStore(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionCategoriaServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionCategoriaServerExceptionMessageStore(objDataState.error));
    }
  }
}
