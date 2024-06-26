import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_id_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_fichero/inspeccion_fichero_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_fichero/delete_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_fichero/list_inspeccion_fichero_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/inspeccion_fichero/store_inspeccion_fichero_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_inspeccion_fichero_event.dart';
part 'remote_inspeccion_fichero_state.dart';

class RemoteInspeccionFicheroBloc extends Bloc<RemoteInspeccionFicheroEvent, RemoteInspeccionFicheroState> {
  RemoteInspeccionFicheroBloc(
    this._listInspeccionFicheroUseCase,
    this._storeInspeccionFicheroUseCase,
    this._deleteInspeccionFicheroUseCase,
  ) : super(RemoteInspeccionFicheroInitial()) {
    on<ListInspeccionFicheros>(onListInspeccionFicheros);
    on<StoreInspeccionFichero>(onStoreInspeccionFichero);
    on<DeleteInspeccionFichero>(onDeleteInspeccionFichero);
  }

  // Casos de uso
  final ListInspeccionFicheroUseCase _listInspeccionFicheroUseCase;
  final StoreInspeccionFicheroUseCase _storeInspeccionFicheroUseCase;
  final DeleteInspeccionFicheroUseCase _deleteInspeccionFicheroUseCase;

  Future<void> onListInspeccionFicheros(ListInspeccionFicheros event, Emitter<RemoteInspeccionFicheroState> emit) async {
    emit(RemoteInspeccionFicheroLoading());

    final objDataState = await _listInspeccionFicheroUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionFicheroSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFicheroServerFailedMessageList(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFicheroServerFailureList(objDataState.serverException));
    }
  }

  Future<void> onStoreInspeccionFichero(StoreInspeccionFichero event, Emitter<RemoteInspeccionFicheroState> emit) async {
    emit(RemoteInspeccionFicheroStoreLoading());

    final objDataState = await _storeInspeccionFicheroUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionFicheroStoreSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFicheroServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFicheroServerFailureStore(objDataState.serverException));
    }
  }

  Future<void> onDeleteInspeccionFichero(DeleteInspeccionFichero event, Emitter<RemoteInspeccionFicheroState> emit) async {
    emit(RemoteInspeccionFicheroDeleteLoading());

    final objDataState = await _deleteInspeccionFicheroUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionFicheroDeleteSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionFicheroServerFailedMessageDelete(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionFicheroServerFailureDelete(objDataState.serverException));
    }
  }
}
