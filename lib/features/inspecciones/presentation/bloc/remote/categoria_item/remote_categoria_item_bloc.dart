import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_list_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_params_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_update_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_delete_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_list_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_store_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_store_duplicate_categoria_item.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_update_categoria_item_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:eos_mobile/shared/shared_models.dart';

part 'remote_categoria_item_event.dart';
part 'remote_categoria_item_state.dart';

class RemoteCategoriaItemBloc extends Bloc<RemoteCategoriaItemEvent, RemoteCategoriaItemState> {
  RemoteCategoriaItemBloc(
    this._remoteListCategoriaItemUseCase,
    this._remoteStoreCategoriaItemUseCase,
    this._remoteStoreDuplicateCategoriaItemUseCase,
    this._remoteUpdateCategoriaItemUseCase,
    this._remoteDeleteCategoriaItemUseCase,
  ) : super(RemoteCategoriaItemInit()) {
    on<ListCategoriasItems>(onListCategoriasItems);
    on<StoreCategoriaItem>(onStoreCategoriaItem);
    on<StoreDuplicateCategoriaItem>(onStoreDuplicateCategoriaItem);
    on<UpdateCategoriaItem>(onUpdateCategoriaItem);
    on<DeleteCategoriaItem>(onDeleteCategoriaItem);
  }

  // USE CASES
  final RemoteListCategoriaItemUseCase _remoteListCategoriaItemUseCase;
  final RemoteStoreCategoriaItemUseCase _remoteStoreCategoriaItemUseCase;
  final RemoteStoreDuplicateCategoriaItemUseCase _remoteStoreDuplicateCategoriaItemUseCase;
  final RemoteUpdateCategoriaItemUseCase _remoteUpdateCategoriaItemUseCase;
  final RemoteDeleteCategoriaItemUseCase _remoteDeleteCategoriaItemUseCase;

  Future<void> onListCategoriasItems(ListCategoriasItems event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemLoading());

    final objDataState = await _remoteListCategoriaItemUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemList(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemServerFailedMessageList(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemServerExceptionMessageList(objDataState.error));
    }
  }

  Future<void> onStoreCategoriaItem(StoreCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemStoreLoading());

    final objDataState = await _remoteStoreCategoriaItemUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemStore(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemServerExceptionMessageStore(objDataState.error));
    }
  }

  Future<void> onStoreDuplicateCategoriaItem(StoreDuplicateCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemStoreDuplicateLoading());

    final objDataState = await _remoteStoreDuplicateCategoriaItemUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemStoreDuplicate(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemServerFailedMessageStoreDuplicate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemServerExceptionMessageStoreDuplicate(objDataState.error));
    }
  }

  Future<void> onUpdateCategoriaItem(UpdateCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemUpdateLoading());

    final objDataState = await _remoteUpdateCategoriaItemUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemUpdate(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemServerFailedMessageUpdate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemServerExceptionMessageUpdate(objDataState.error));
    }
  }

  Future<void> onDeleteCategoriaItem(DeleteCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemDeleteLoading());

    final objDataState = await _remoteDeleteCategoriaItemUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemDelete(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemServerFailedMessageDelete(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemServerExceptionMessageDelete(objDataState.error));
    }
  }
}
