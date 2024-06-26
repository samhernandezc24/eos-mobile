import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/delete_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/list_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/store_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_tipo/update_inspeccion_tipo_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

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
  final ListInspeccionTipoUseCase _listInspeccionesTiposUseCase;
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
      emit(RemoteInspeccionTipoServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreInspeccionTipo(StoreInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoStoring());

    final objDataState = await _storeInspeccionTipoUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoStored(objDataState.data));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoServerFailedMessage(objDataState.errorMessage));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerFailure(objDataState.serverException));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }
  }

  Future<void> onUpdateInspeccionTipo(UpdateInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoUpdating());

    final objDataState = await _updateInspeccionTipoUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoUpdated(objDataState.data));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoServerFailedMessage(objDataState.errorMessage));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerFailure(objDataState.serverException));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }
  }

  Future<void> onDeleteInspeccionTipo(DeleteInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoDeleting());

    final objDataState = await _deleteInspeccionTipoUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoDeleted(objDataState.data));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoServerFailedMessage(objDataState.errorMessage));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerFailure(objDataState.serverException));
      await onListInspeccionesTipos(ListInspeccionesTipos(), emit);
    }
  }
}
