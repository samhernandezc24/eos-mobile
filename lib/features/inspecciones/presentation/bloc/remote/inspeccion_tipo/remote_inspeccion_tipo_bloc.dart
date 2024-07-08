import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_delete_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_list_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_store_inspeccion_tipo_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_tipo/remote_update_inspeccion_tipo_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

part 'remote_inspeccion_tipo_event.dart';
part 'remote_inspeccion_tipo_state.dart';

class RemoteInspeccionTipoBloc extends Bloc<RemoteInspeccionTipoEvent, RemoteInspeccionTipoState> {
  RemoteInspeccionTipoBloc(
    this._remoteListInspeccionTipoUseCase,
    this._remoteStoreInspeccionTipoUseCase,
    this._remoteUpdateInspeccionTipoUseCase,
    this._remoteDeleteInspeccionTipoUseCase,
  ) : super(RemoteInspeccionTipoInit()) {
    on<ListInspeccionesTipos>(onListInspeccionesTipos);
    on<StoreInspeccionTipo>(onStoreInspeccionTipo);
    on<UpdateInspeccionTipo>(onUpdateInspeccionTipo);
    on<DeleteInspeccionTipo>(onDeleteInspeccionTipo);
  }

  // USE CASES
  final RemoteListInspeccionTipoUseCase _remoteListInspeccionTipoUseCase;
  final RemoteStoreInspeccionTipoUseCase _remoteStoreInspeccionTipoUseCase;
  final RemoteUpdateInspeccionTipoUseCase _remoteUpdateInspeccionTipoUseCase;
  final RemoteDeleteInspeccionTipoUseCase _remoteDeleteInspeccionTipoUseCase;

  Future<void> onListInspeccionesTipos(ListInspeccionesTipos event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoLoading());

    final objDataState = await _remoteListInspeccionTipoUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoList(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoServerFailedMessageList(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerExceptionMessageList(objDataState.error));
    }
  }

  Future<void> onStoreInspeccionTipo(StoreInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoStoreLoading());

    final objDataState = await _remoteStoreInspeccionTipoUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoStore(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerExceptionMessageStore(objDataState.error));
    }
  }

  Future<void> onUpdateInspeccionTipo(UpdateInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoUpdateLoading());

    final objDataState = await _remoteUpdateInspeccionTipoUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoUpdate(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoServerFailedMessageUpdate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerExceptionMessageUpdate(objDataState.error));
    }
  }

  Future<void> onDeleteInspeccionTipo(DeleteInspeccionTipo event, Emitter<RemoteInspeccionTipoState> emit) async {
    emit(RemoteInspeccionTipoDeleteLoading());

    final objDataState = await _remoteDeleteInspeccionTipoUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionTipoDelete(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionTipoServerFailedMessageDelete(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionTipoServerExceptionMessageDelete(objDataState.error));
    }
  }
}
