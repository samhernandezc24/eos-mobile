import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/list_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/sotre_duplicate_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/store_categoria_item_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_categoria_item_event.dart';
part 'remote_categoria_item_state.dart';

class RemoteCategoriaItemBloc extends Bloc<RemoteCategoriaItemEvent, RemoteCategoriaItemState> {
  RemoteCategoriaItemBloc(
    this._listCategoriaItemUseCase,
    this._storeCategoriaItemUseCase,
    this._storeDuplicateCategoriaItemUseCase,
  ) : super(RemoteCategoriaItemLoading()) {
    on<ListCategoriasItems>(onListCategoriasItems);
    on<StoreCategoriaItem>(onStoreCategoriaItem);
    on<StoreDuplicateCategoriaItem>(onStoreDuplicateCategoriaItem);
  }

  // Casos de uso
  final ListCategoriaItemUseCase _listCategoriaItemUseCase;
  final StoreCategoriaItemUseCase _storeCategoriaItemUseCase;
  final StoreDuplicateCategoriaItemUseCase _storeDuplicateCategoriaItemUseCase;

  Future<void> onListCategoriasItems(ListCategoriasItems event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemLoading());

    final objDataState = await _listCategoriaItemUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemServerFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreCategoriaItem(StoreCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemStoring());

    final objDataState = await _storeCategoriaItemUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemStored(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemServerFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreDuplicateCategoriaItem(StoreDuplicateCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemStoringDuplicate());

    final objDataState = await _storeDuplicateCategoriaItemUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemStoredDuplicate(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemServerFailure(objDataState.serverException));
    }
  }
}
