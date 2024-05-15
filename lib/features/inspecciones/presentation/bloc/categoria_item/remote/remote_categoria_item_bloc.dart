import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria_item/categoria_item_data_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria_item/list_categoria_item_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_categoria_item_event.dart';
part 'remote_categoria_item_state.dart';

class RemoteCategoriaItemBloc extends Bloc<RemoteCategoriaItemEvent, RemoteCategoriaItemState> {
  RemoteCategoriaItemBloc(
    this._listCategoriaItemUseCase,
  ) : super(RemoteCategoriaItemLoading()) {
    on<ListCategoriasItems>(onListCategoriasItems);
  }

  // Casos de uso
  final ListCategoriaItemUseCase _listCategoriaItemUseCase;

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
}
