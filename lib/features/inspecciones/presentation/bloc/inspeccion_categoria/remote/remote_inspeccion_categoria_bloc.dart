import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_categoria/inspeccion_categoria_checklist_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_categoria/get_preguntas_inspeccion_categoria_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_inspeccion_categoria_event.dart';
part 'remote_inspeccion_categoria_state.dart';

class RemoteInspeccionCategoriaBloc extends Bloc<RemoteInspeccionCategoriaEvent, RemoteInspeccionCategoriaState> {
  RemoteInspeccionCategoriaBloc(
    this._getPreguntasInspeccionCategoriaUseCase,
  ) : super(RemoteInspeccionCategoriaLoading()) {
    on<GetInspeccionCategoriaPreguntas>(onGetInspeccionCategoriaPreguntas);
  }

  // Casos de uso
  final GetPreguntasInspeccionCategoriaUseCase _getPreguntasInspeccionCategoriaUseCase;

  Future<void> onGetInspeccionCategoriaPreguntas(GetInspeccionCategoriaPreguntas event, Emitter<RemoteInspeccionCategoriaState> emit) async {
    emit(RemoteInspeccionCategoriaLoading());

    final objDataState = await _getPreguntasInspeccionCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCategoriaGetPreguntasSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionCategoriaServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionCategoriaServerFailure(objDataState.serverException));
    }
  }
}
