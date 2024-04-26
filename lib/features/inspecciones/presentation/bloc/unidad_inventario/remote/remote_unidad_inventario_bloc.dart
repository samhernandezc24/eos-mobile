import 'package:eos_mobile/core/data/predictive_search_req_data.dart';
import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/exceptions.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/unidad_inventario/unidad_inventario_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/unidad_inventario/predictive_unidad_inventario_usecase.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_unidad_inventario_event.dart';
part 'remote_unidad_inventario_state.dart';

class RemoteUnidadInventarioBloc extends Bloc<RemoteUnidadInventarioEvent, RemoteUnidadInventarioState> {
  RemoteUnidadInventarioBloc(this._predictiveUnidadInventarioUseCase) : super(RemoteUnidadInventarioLoading()) {
    on<PredictiveUnidadInventario>(onPredictiveUnidadInventario);
  }

  // Casos de uso
  final PredictiveUnidadInventarioUseCase _predictiveUnidadInventarioUseCase;

  Future<void> onPredictiveUnidadInventario(PredictiveUnidadInventario event, Emitter<RemoteUnidadInventarioState> emit) async {
    emit(RemoteUnidadInventarioLoading());

    final objDataState = await _predictiveUnidadInventarioUseCase(params: event.predictiveSearch);

    if (objDataState is DataSuccess) {
      emit(RemoteUnidadInventarioSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteUnidadInventarioFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteUnidadInventarioFailure(objDataState.serverException));
    }
  }
}
