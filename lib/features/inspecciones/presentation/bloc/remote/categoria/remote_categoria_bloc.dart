import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria/remote_delete_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria/remote_list_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria/remote_store_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria/remote_update_categoria_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

part 'remote_categoria_event.dart';
part 'remote_categoria_state.dart';

class RemoteCategoriaBloc extends Bloc<RemoteCategoriaEvent, RemoteCategoriaState> {
  RemoteCategoriaBloc(
    this._remoteListCategoriaUseCase,
    this._remoteStoreCategoriaUseCase,
    this._remoteUpdateCategoriaUseCase,
    this._remoteDeleteCategoriaUseCase,
  ) : super(RemoteCategoriaInit()) {
    on<ListCategorias>(onListCategorias);
    on<StoreCategoria>(onStoreCategoria);
    on<UpdateCategoria>(onUpdateCategoria);
    on<DeleteCategoria>(onDeleteCategoria);
  }

  // USE CASES
  final RemoteListCategoriaUseCase _remoteListCategoriaUseCase;
  final RemoteStoreCategoriaUseCase _remoteStoreCategoriaUseCase;
  final RemoteUpdateCategoriaUseCase _remoteUpdateCategoriaUseCase;
  final RemoteDeleteCategoriaUseCase _remoteDeleteCategoriaUseCase;

  Future<void> onListCategorias(ListCategorias event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaLoading());

    final objDataState = await _remoteListCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaList(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaServerFailedMessageList(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaServerExceptionMessageList(objDataState.error));
    }
  }

  Future<void> onStoreCategoria(StoreCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaStoreLoading());

    final objDataState = await _remoteStoreCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaStore(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaServerExceptionMessageStore(objDataState.error));
    }
  }

  Future<void> onUpdateCategoria(UpdateCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaUpdateLoading());

    final objDataState = await _remoteUpdateCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaUpdate(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaServerFailedMessageUpdate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaServerExceptionMessageUpdate(objDataState.error));
    }
  }

  Future<void> onDeleteCategoria(DeleteCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaDeleteLoading());

    final objDataState = await _remoteDeleteCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaDelete(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaServerFailedMessageDelete(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaServerExceptionMessageDelete(objDataState.error));
    }
  }
}
