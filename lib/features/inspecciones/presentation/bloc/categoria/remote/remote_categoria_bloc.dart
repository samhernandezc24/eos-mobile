import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/core/network/errors/exceptions.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/categoria/categoria_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion_tipo/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/delete_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/list_categorias_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/store_categoria_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/categoria/update_categoria_usecase.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_categoria_event.dart';
part 'remote_categoria_state.dart';

class RemoteCategoriaBloc extends Bloc<RemoteCategoriaEvent, RemoteCategoriaState> {
  RemoteCategoriaBloc(
    this._listCategoriasUseCase,
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
  final ListCategoriasUseCase _listCategoriasUseCase;
  final StoreCategoriaUseCase _storeCategoriaUseCase;
  final UpdateCategoriaUseCase _updateCategoriaUseCase;
  final DeleteCategoriaUseCase _deleteCategoriaUseCase;

  Future<void> onListCategorias(ListCategorias event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaLoading());

    final objDataState = await _listCategoriasUseCase(params: event.inspeccionTipo);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaSuccess(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteCategoriaFailure(objDataState.serverException));
    }
  }

  Future<void> onStoreCategoria(StoreCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaLoading());

    final objDataState = await _storeCategoriaUseCase(params: event.categoria);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaResponseSuccess(objDataState.data!));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      // emit(RemoteCategoriaFailure(objDataState.exception));
    }
  }

  Future<void> onUpdateCategoria(UpdateCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaLoading());

    final objDataState = await _updateCategoriaUseCase(params: event.categoria);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaResponseSuccess(objDataState.data!));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      // emit(RemoteCategoriaFailure(objDataState.exception));
    }
  }

  Future<void> onDeleteCategoria(DeleteCategoria event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaLoading());

    final objDataState = await _deleteCategoriaUseCase(params: event.categoria);

    if (objDataState is DataSuccess) {
      emit(RemoteCategoriaResponseSuccess(objDataState.data!));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteCategoriaFailedMessage(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      // emit(RemoteCategoriaFailure(objDataState.exception));
    }
  }
}
