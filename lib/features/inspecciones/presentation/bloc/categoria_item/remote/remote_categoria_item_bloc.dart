import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_duplicate_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/delete_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/list_categorias_items_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/store_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/store_duplicate_categoria_item_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/update_categoria_item_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_categoria_item_event.dart';
part 'remote_categoria_item_state.dart';

class RemoteCategoriaItemBloc extends Bloc<RemoteCategoriaItemEvent, RemoteCategoriaItemState> {
  RemoteCategoriaItemBloc(
    this._listCategoriasItemsUseCase,
    this._storeCategoriaItemUseCase,
    this._storeDuplicateCategoriaItemUseCase,
    this._updateCategoriaItemUseCase,
    this._deleteCategoriaItemUseCase,
  ) : super(RemoteCategoriaItemLoading()) {
    on<ListCategoriasItems>(onListCategoriasItems);
    on<StoreCategoriaItem>(onStoreCategoriaItem);
    on<StoreDuplicateCategoriaItem>(onStoreDuplicateCategoriaItem);
    on<UpdateCategoriaItem>(onUpdateCategoriaItem);
    on<DeleteCategoriaItem>(onDeleteCategoriaItem);
  }

  // Casos de uso
  final ListCategoriasItemsUseCase _listCategoriasItemsUseCase;
  final StoreCategoriaItemUseCase _storeCategoriaItemUseCase;
  final StoreDuplicateCategoriaItemUseCase _storeDuplicateCategoriaItemUseCase;
  final UpdateCategoriaItemUseCase _updateCategoriaItemUseCase;
  final DeleteCategoriaItemUseCase _deleteCategoriaItemUseCase;

  Future<void> onListCategoriasItems(ListCategoriasItems event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemLoading());

    final objDataState = await _listCategoriasItemsUseCase(params: event.categoria);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemFailure(objDataState.exception));
    }
  }

  Future<void> onStoreCategoriaItem(StoreCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemLoading());

    final objDataState = await _storeCategoriaItemUseCase(params: event.categoriaItem);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemResponseSuccess(objDataState.data!));

      emit(RemoteCategoriaItemLoading());

      final categoria = CategoriaEntity(
        idCategoria           : event.categoriaItem.idCategoria,
        name                  : event.categoriaItem.categoriaName,
        idInspeccionTipo      : event.categoriaItem.idCategoria,
        inspeccionTipoCodigo  : '',
        inspeccionTipoName    : event.categoriaItem.inspeccionTipoName,
      );

      await onListCategoriasItems(ListCategoriasItems(categoria), emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemFailure(objDataState.exception));
    }
  }

  Future<void> onStoreDuplicateCategoriaItem(StoreDuplicateCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemLoading());

    final objDataState = await _storeDuplicateCategoriaItemUseCase(params: event.categoriaItem);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemResponseSuccess(objDataState.data!));

      emit(RemoteCategoriaItemLoading());

      final categoria = CategoriaEntity(
        idCategoria           : event.categoriaItem.idCategoria,
        name                  : event.categoriaItem.categoriaName,
        idInspeccionTipo      : event.categoriaItem.idCategoria,
        inspeccionTipoCodigo  : '',
        inspeccionTipoName    : event.categoriaItem.inspeccionTipoName,
      );

      await onListCategoriasItems(ListCategoriasItems(categoria), emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemFailure(objDataState.exception));
    }
  }

  Future<void> onUpdateCategoriaItem(UpdateCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    final objDataState = await _updateCategoriaItemUseCase(params: event.categoriaItem);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemResponseSuccess(objDataState.data!));

      emit(RemoteCategoriaItemLoading());

      final categoria = CategoriaEntity(
        idCategoria           : event.categoriaItem.idCategoria,
        name                  : event.categoriaItem.categoriaName,
        idInspeccionTipo      : event.categoriaItem.idCategoria,
        inspeccionTipoCodigo  : '',
        inspeccionTipoName    : '',
      );

      await onListCategoriasItems(ListCategoriasItems(categoria), emit);
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemFailure(objDataState.exception));
    }
  }

  Future<void> onDeleteCategoriaItem(DeleteCategoriaItem event, Emitter<RemoteCategoriaItemState> emit) async {
    emit(RemoteCategoriaItemLoading());

    final objDataState = await _deleteCategoriaItemUseCase(params: event.categoriaItem);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaItemResponseSuccess(objDataState.data!));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaItemFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaItemFailure(objDataState.exception));
    }
  }
}
