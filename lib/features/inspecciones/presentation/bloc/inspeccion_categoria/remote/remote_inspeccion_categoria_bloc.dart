import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_checklist_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_categoria/get_preguntas_inspeccion_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_categoria/store_inspeccion_categoria_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_inspeccion_categoria_event.dart';
part 'remote_inspeccion_categoria_state.dart';

class RemoteInspeccionCategoriaBloc extends Bloc<RemoteInspeccionCategoriaEvent, RemoteInspeccionCategoriaState> {
  RemoteInspeccionCategoriaBloc(
    this._getPreguntasInspeccionCategoriaUseCase,
    this._storeInspeccionCategoriaUseCase,
  ) : super(RemoteInspeccionCategoriaInitial()) {
    on<GetPreguntas>(onGetInspeccionCategoriaPreguntas);
    on<StoreInspeccionCategoria>(onStoreInspeccionCategoria);
  }

  // Casos de uso
  final GetPreguntasInspeccionCategoriaUseCase _getPreguntasInspeccionCategoriaUseCase;
  final StoreInspeccionCategoriaUseCase _storeInspeccionCategoriaUseCase;

  Future<void> onGetInspeccionCategoriaPreguntas(GetPreguntas event, Emitter<RemoteInspeccionCategoriaState> emit) async {
    emit(RemoteInspeccionCategoriaGetPreguntasLoading());

    final objDataState = await _getPreguntasInspeccionCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCategoriaGetPreguntasSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionCategoriaServerFailedMessageGetPreguntas(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionCategoriaServerFailureGetPreguntas(objDataState.serverException));
    }
  }

  Future<void> onStoreInspeccionCategoria(StoreInspeccionCategoria event, Emitter<RemoteInspeccionCategoriaState> emit) async {
    emit(RemoteInspeccionCategoriaStoreLoading());

    final objDataState = await _storeInspeccionCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCategoriaStoreSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionCategoriaServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionCategoriaServerFailureStore(objDataState.serverException));
    }
  }
}
