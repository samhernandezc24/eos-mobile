import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/create_inspeccion_tipo.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/fetch_inspeccion_tipo.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_inspeccion_tipo_event.dart';
part 'remote_inspeccion_tipo_state.dart';

class RemoteInspeccionTipoBloc extends Bloc<RemoteInspeccionTipoEvent, RemoteInspeccionTipoState> {
  RemoteInspeccionTipoBloc(this._fetchInspeccionTipoUseCase, this._createInspeccionTipoUseCase) : super(RemoteInspeccionTipoInitial()) {
    on<FetcInspeccionesTipos>(_onFetchInspeccionesTipos);
    on<CreateInspeccionTipo>(_onCreateInspeccionTipo);
  }

  final FetchInspeccionTipoUseCase _fetchInspeccionTipoUseCase;
  final CreateInspeccionTipoUseCase _createInspeccionTipoUseCase;

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

  Future<void> _onCreateInspeccionTipo(CreateInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final dataState = await _createInspeccionTipoUseCase(event.inspeccionTipoReq);

    if (dataState is DataSuccess) {
      emit(RemoteInspeccionTipoCreateDone(dataState.data!));
    }

    if (dataState is DataFailedMessage) {
      emit(RemiteInspeccionTipoFailedMessage(dataState.errorMessage));
    }

    if (dataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(dataState.exception));
    }
  }
}
