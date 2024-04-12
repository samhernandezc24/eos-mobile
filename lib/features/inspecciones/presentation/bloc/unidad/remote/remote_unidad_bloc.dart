import 'package:eos_mobile/core/common/data/catalogos/unidad_data.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad/unidad_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad/create_unidad_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_unidad_event.dart';
part 'remote_unidad_state.dart';

class RemoteUnidadBloc extends Bloc<RemoteUnidadEvent, RemoteUnidadState> {
  RemoteUnidadBloc(
    this._createUnidadUseCase,
  ) : super(RemoteUnidadLoading()) {
    on<CreateUnidad>(onCreateUnidad);
  }

  // Casos de uso
  final CreateUnidadUseCase _createUnidadUseCase;

  Future<void> onCreateUnidad(CreateUnidad event, Emitter<RemoteUnidadState> emit) async {
    emit(RemoteUnidadLoading());

    final objDataState = await _createUnidadUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadCreateSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadFailure(objDataState.exception));
    }
  }
}
