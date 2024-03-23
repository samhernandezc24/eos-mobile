import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspecciones_tipos/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/inspecciones_tipos/create_inspeccion_tipo.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/inspecciones_tipos/delete_inspeccion_tipo.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/inspecciones_tipos/fetch_inspeccion_tipo.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/inspecciones_tipos/update_inspeccion_tipo.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/inspecciones_tipos/update_orden_inspeccion_tipo.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_inspeccion_tipo_event.dart';
part 'remote_inspeccion_tipo_state.dart';

class RemoteInspeccionTipoBloc extends Bloc<RemoteInspeccionTipoEvent, RemoteInspeccionTipoState> {
  RemoteInspeccionTipoBloc(
    this._fetchInspeccionTipoUseCase,
    this._createInspeccionTipoUseCase,
    this._updateInspeccionTipoUseCase,
    this._updateOrdenInspeccionTipoUseCase,
    this._deleteInspeccionTipoUseCase,
  ) : super(RemoteInspeccionTipoLoading()) {
    on<FetcInspeccionesTipos>(_onFetchInspeccionesTipos);
    on<CreateInspeccionTipo>(_onCreateInspeccionTipo);
    on<UpdateInspeccionTipo>(_onUpdateInspeccionTipo);
    on<UpdateOrdenInspeccionTipo>(_onUpdateOrdenInspeccionTipo);
    on<DeleteInspeccionTipo>(_onDeleteInspeccionTipo);
  }

  final FetchInspeccionTipoUseCase _fetchInspeccionTipoUseCase;
  final CreateInspeccionTipoUseCase _createInspeccionTipoUseCase;
  final UpdateInspeccionTipoUseCase _updateInspeccionTipoUseCase;
  final UpdateOrdenInspeccionTipoUseCase _updateOrdenInspeccionTipoUseCase;
  final DeleteInspeccionTipoUseCase _deleteInspeccionTipoUseCase;

  Future<void> _onFetchInspeccionesTipos(FetcInspeccionesTipos event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final dataState = await _fetchInspeccionTipoUseCase(NoParams());

    if (dataState is DataSuccess) {
      emit(RemoteInspeccionTipoDone(dataState.data));
    }

    if (dataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(dataState.exception));
    }
  }

  Future<void> _onCreateInspeccionTipo(CreateInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final dataState = await _createInspeccionTipoUseCase(event.inspeccionTipoReq);

    if (dataState is DataSuccess) {
      emit(RemoteInspeccionResponseSuccess(dataState.data!));
    }

    if (dataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoFailedMessage(dataState.errorMessage));
    }

    if (dataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(dataState.exception));
    }
  }

  Future<void> _onUpdateInspeccionTipo(UpdateInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final dataState = await _updateInspeccionTipoUseCase(event.inspeccionTipoReq);

    if (dataState is DataSuccess) {
      emit(RemoteInspeccionResponseSuccess(dataState.data!));
    }

    if (dataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoFailedMessage(dataState.errorMessage));
    }

    if (dataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(dataState.exception));
    }
  }

  Future<void> _onUpdateOrdenInspeccionTipo(UpdateOrdenInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final dataState = await _updateOrdenInspeccionTipoUseCase(event.inspeccionesTipos);

    if (dataState is DataSuccess) {
      emit(RemoteInspeccionResponseSuccess(dataState.data!));
    }

    if (dataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoFailedMessage(dataState.errorMessage));
    }

    if (dataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(dataState.exception));
    }
  }

  Future<void> _onDeleteInspeccionTipo(DeleteInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final dataState = await _deleteInspeccionTipoUseCase(event.inspeccionTipo);

    if (dataState is DataSuccess) {
      emit(RemoteInspeccionResponseSuccess(dataState.data!));
    }

    if (dataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoFailedMessage(dataState.errorMessage));
    }

    if (dataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(dataState.exception));
    }
  }

  // METODOS
  Future<int> getCurrentOrder() async {
    try {
      final dataState = await _fetchInspeccionTipoUseCase(NoParams());
      if (dataState is DataSuccess<List<InspeccionTipoEntity>>) {
        final currentOrder = dataState.data!.length + 1;
        return currentOrder;
      } else {
        throw Exception('Error al obtener el número actual de registros');
      }
    } catch (e) {
      throw Exception('Error al obtener el número actual de registros: $e');
    }
  }
}
