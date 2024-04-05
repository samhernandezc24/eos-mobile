import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspecciones_tipos/list_inspecciones_tipos_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_inspeccion_tipo_event.dart';
part 'remote_inspeccion_tipo_state.dart';

class RemoteInspeccionTipoBloc extends Bloc<RemoteInspeccionTipoEvent, RemoteInspeccionTipoState> {
  RemoteInspeccionTipoBloc(this._listInspeccionesTiposUseCase) : super(RemoteInspeccionTipoLoading()) {
    on<ListInspeccionesTipos>(onListInspeccionesTipos);
  }

  // Casos de uso
  final ListInspeccionesTiposUseCase _listInspeccionesTiposUseCase;

  Future<void> onListInspeccionesTipos(ListInspeccionesTipos event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final objDataState = await _listInspeccionesTiposUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(objDataState.exception));
    }
  }
}
