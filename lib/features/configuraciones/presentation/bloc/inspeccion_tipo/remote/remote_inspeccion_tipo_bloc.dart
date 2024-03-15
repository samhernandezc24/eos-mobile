import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/fetch_inspeccion_tipo.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_inspeccion_tipo_event.dart';
part 'remote_inspeccion_tipo_state.dart';

class RemoteInspeccionTipoBloc extends Bloc<RemoteInspeccionTipoEvent, RemoteInspeccionTipoState> {
  RemoteInspeccionTipoBloc(this._fetchInspeccionTipoUseCase) : super(RemoteInspeccionTipoInitial()) {
    on<FetcInspeccionesTipos>(_onFetchInspeccionesTipos);
  }

  final FetchInspeccionTipoUseCase _fetchInspeccionTipoUseCase;

  Future<void> _onFetchInspeccionesTipos(FetcInspeccionesTipos event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final dataState = await _fetchInspeccionTipoUseCase(NoParams());

    if (dataState is DataSuccess) {
      if (dataState.data!.isEmpty) {
        emit(RemoteInspeccionTipoInitial());
      } else {
        emit(RemoteInspeccionTipoDone(dataState.data));
      }
    }

    if (dataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(dataState.exception));
    }
  }
}
