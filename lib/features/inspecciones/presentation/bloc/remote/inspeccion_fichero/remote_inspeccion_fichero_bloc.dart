import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_fichero/remote_delete_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_fichero/remote_list_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion_fichero/remote_store_inspeccion_fichero_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

part 'remote_inspeccion_fichero_event.dart';
part 'remote_inspeccion_fichero_state.dart';

class RemoteInspeccionFicheroBloc extends Bloc<RemoteInspeccionFicheroEvent, RemoteInspeccionFicheroState> {
  RemoteInspeccionFicheroBloc(
    this._remoteListInspeccionFicheroUseCase,
    this._remoteStoreInspeccionFicheroUseCase,
    this._remoteDeleteInspeccionFicheroUseCase,
  ) : super(RemoteInspeccionFicheroInit()) {
    on<ListFicheros>(onListFicheros);
    on<StoreInspeccionFichero>(onStoreInspeccionFichero);
    on<DeleteInspeccionFichero>(onDeleteInspeccionFichero);
  }

  // USE CASES
  final RemoteListInspeccionFicheroUseCase _remoteListInspeccionFicheroUseCase;
  final RemoteStoreInspeccionFicheroUseCase _remoteStoreInspeccionFicheroUseCase;
  final RemoteDeleteInspeccionFicheroUseCase _remoteDeleteInspeccionFicheroUseCase;

  Future<void> onListFicheros(ListFicheros event, Emitter<RemoteInspeccionFicheroState> emit) async {
    emit(RemoteInspeccionFicheroListLoading());

    final objDataState = await _remoteListInspeccionFicheroUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionFicheroList(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFicheroServerFailedMessageList(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFicheroServerExceptionMessageList(objDataState.error));
    }
  }

  Future<void> onStoreInspeccionFichero(StoreInspeccionFichero event, Emitter<RemoteInspeccionFicheroState> emit) async {
    emit(RemoteInspeccionFicheroStoreLoading());

    final objDataState = await _remoteStoreInspeccionFicheroUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionFicheroStore(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFicheroServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFicheroServerExceptionMessageStore(objDataState.error));
    }
  }

  Future<void> onDeleteInspeccionFichero(DeleteInspeccionFichero event, Emitter<RemoteInspeccionFicheroState> emit) async {
    emit(RemoteInspeccionFicheroDeleteLoading());

    final objDataState = await _remoteDeleteInspeccionFicheroUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionFicheroDelete(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFicheroServerFailedMessageDelete(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFicheroServerExceptionMessageDelete(objDataState.error));
    }
  }
}
