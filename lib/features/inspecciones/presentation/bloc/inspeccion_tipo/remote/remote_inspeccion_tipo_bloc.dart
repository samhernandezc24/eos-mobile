import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/dio_exception.dart';
import 'package:eos_mobile/core/usecases/usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/delete_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/list_inspecciones_tipos_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/store_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/update_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_inspeccion_tipo_event.dart';
part 'remote_inspeccion_tipo_state.dart';

class RemoteInspeccionTipoBloc extends Bloc<RemoteInspeccionTipoEvent, RemoteInspeccionTipoState> {
  RemoteInspeccionTipoBloc(
    this._listInspeccionesTiposUseCase,
    this._storeInspeccionTipoUseCase,
    this._updateInspeccionTipoUseCase,
    this._deleteInspeccionTipoUseCase,
  ) : super(RemoteInspeccionTipoLoading()) {
    on<ListInspeccionesTipos>(onListInspeccionesTipos);
    on<StoreInspeccionTipo>(onStoreInspeccionTipo);
    on<UpdateInspeccionTipo>(onUpdateInspeccionTipo);
    on<DeleteInspeccionTipo>(onDeleteInspeccionTipo);
  }

  // Casos de uso
  final ListInspeccionesTiposUseCase _listInspeccionesTiposUseCase;
  final StoreInspeccionTipoUseCase _storeInspeccionTipoUseCase;
  final UpdateInspeccionTipoUseCase _updateInspeccionTipoUseCase;
  final DeleteInspeccionTipoUseCase _deleteInspeccionTipoUseCase;

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
      emit(RemoteInspeccionTipoFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreInspeccionTipo(StoreInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final objDataState = await _storeInspeccionTipoUseCase(params: event.inspeccionTipo);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoResponseSuccess(objDataState.data!));
      await _reloadInspeccionesTipos(emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoFailedMessage(objDataState.errorMessage));
      await _reloadInspeccionesTipos(emit);
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(objDataState.serverException));
      await _reloadInspeccionesTipos(emit);
    }
  }

  Future<void> onUpdateInspeccionTipo(UpdateInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final objDataState = await _updateInspeccionTipoUseCase(params: event.inspeccionTipo);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoResponseSuccess(objDataState.data!));
      await _reloadInspeccionesTipos(emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoFailedMessage(objDataState.errorMessage));
      await _reloadInspeccionesTipos(emit);
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(objDataState.serverException));
      await _reloadInspeccionesTipos(emit);
    }
  }

  Future<void> onDeleteInspeccionTipo(DeleteInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final objDataState = await _deleteInspeccionTipoUseCase(params: event.inspeccionTipo);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoResponseSuccess(objDataState.data!));
      await _reloadInspeccionesTipos(emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoFailedMessage(objDataState.errorMessage));
      await _reloadInspeccionesTipos(emit);
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoFailure(objDataState.serverException));
      await _reloadInspeccionesTipos(emit);
    }
  }

  /// Recargar el listado de inspecciones tipos.
  Future<void> _reloadInspeccionesTipos(Emitter<RemoteInspeccionTipoState> emit) async {
    await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
  }
}
