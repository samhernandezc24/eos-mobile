import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_id_param_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_list_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_list_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/categoria_item/remote_store_categoria_item_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part 'remote_categoria_item_event.dart';
part 'remote_categoria_item_state.dart';

class RemoteCategoriaItemBloc extends Bloc<RemoteCategoriaItemEvent, RemoteCategoriaItemState> {
  RemoteCategoriaItemBloc(
    this._remoteListCategoriaItemUseCase,
    this._remoteStoreCategoriaItemUseCase,
  ) : super(RemoteCategoriaItemInit()) {
    on<ListCategoriasItems>(onListCategoriasItems);
    on<StoreCategoriaItem>(onStoreCategoriaItem);
  }

  // USE CASES
  final RemoteListCategoriaItemUseCase _remoteListCategoriaItemUseCase;
  final RemoteStoreCategoriaItemUseCase _remoteStoreCategoriaItemUseCase;

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
}
