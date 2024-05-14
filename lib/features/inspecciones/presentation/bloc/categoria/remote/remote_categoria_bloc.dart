import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/delete_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/list_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/store_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/update_categoria_usecase.dart';

import 'package:eos_mobile/shared/shared_libraries.dart';

part 'remote_categoria_event.dart';
part 'remote_categoria_state.dart';

class RemoteCategoriaBloc extends Bloc<RemoteCategoriaEvent, RemoteCategoriaState> {
  RemoteCategoriaBloc(
    this._listCategoriaUseCase,
    this._storeCategoriaUseCase,
    this._updateCategoriaUseCase,
    this._deleteCategoriaUseCase,
  ) : super(RemoteCategoriaLoading()) {
    on<ListCategorias>(onListCategorias);
    on<StoreCategoria>(onStoreCategoria);
    on<UpdateCategoria>(onUpdateCategoria);
    on<DeleteCategoria>(onDeleteCategoria);
  }

  // Casos de uso
  final ListCategoriaUseCase _listCategoriaUseCase;
  final StoreCategoriaUseCase _storeCategoriaUseCase;
  final UpdateCategoriaUseCase _updateCategoriaUseCase;
  final DeleteCategoriaUseCase _deleteCategoriaUseCase;

  Future<void> onListCategorias(ListCategorias event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaLoading());

    final objDataState = await _listCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaServerFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreCategoria(StoreCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaStoring());

    final objDataState = await _storeCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaStored(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaServerFailure(objDataState.serverException));
    }
  }

  Future<void> onUpdateCategoria(UpdateCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaUpdating());

    final objDataState = await _updateCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaUpdated(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaServerFailure(objDataState.serverException));
    }
  }

  Future<void> onDeleteCategoria(DeleteCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaDeleting());

    final objDataState = await _deleteCategoriaUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaDeleted(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaServerFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaServerFailure(objDataState.serverException));
    }
  }
}
