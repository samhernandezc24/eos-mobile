import 'package:eos_mobile/core/network/api_response.dart';
import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/categoria_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_req_entity.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/categorias/fetch_categoria_by_id_inspeccion_tipo.dart';
import 'package:eos_mobile/shared/shared.dart';

part 'remote_categoria_event.dart';
part 'remote_categoria_state.dart';

class RemoteCategoriaBloc extends Bloc<RemoteCategoriaEvent, RemoteCategoriaState> {
  RemoteCategoriaBloc(
    this._fetchCategoriaByIdInspeccionTipoUseCase,
    // this._createCategoriaUseCase,
    // this._updateCategoriaUseCase,
    // this._deleteCategoriaUseCase,
  ) : super(RemoteCategoriaInitial()) {
    on<FetchCategoriasByIdInspeccionTipo>(_onFetchCategoriasByIdInspeccionTipo);
    // on<CreateCategoria>(_onCreateCategoria);
    // on<UpdateCategoria>(_onUpdateCategoria);
    // on<DeleteCategoria>(_onDeleteCategoria);
  }

  final FetchCategoriaByIdInspeccionTipoUseCase _fetchCategoriaByIdInspeccionTipoUseCase;
  // final CreateCategoriaUseC _createCategoriaUseCase;
  // final UpdateCategoriaUseCase _updateCategoriaUseCase;
  // final DeleteCategoriaUseCase _deleteCategoriaUseCase;

  Future<void> _onFetchCategoriasByIdInspeccionTipo(FetchCategoriasByIdInspeccionTipo event, Emitter<RemoteCategoriaState> emit) async {
    emit(RemoteCategoriaLoading());

    final dataState = await _fetchCategoriaByIdInspeccionTipoUseCase(event.inspeccionTipoReq);

    if (dataState is DataSuccess) {
      if (dataState.data!.isEmpty) {
        emit(RemoteCategoriaInitial());
      } else {
        emit(RemoteCategoriaDone(dataState.data));
      }
    }

    if (dataState is DataFailed) {
      emit(RemoteCategoriaFailure(dataState.exception));
    }
  }

  // Future<void> _onCreateCategoria(CreateCategoria event, Emitter<RemoteCategoriaState> emit) async {
  //   emit(RemoteCategoriaLoading());

  //   final dataState = await _createCategoriaUseCase(event.CategoriaReq);

  //   if (dataState is DataSuccess) {
  //     emit(RemoteCategoriaCreateDone(dataState.data!));
  //   }

  //   if (dataState is DataFailedMessage) {
  //     emit(RemiteCategoriaFailedMessage(dataState.errorMessage));
  //   }

  //   if (dataState is DataFailed) {
  //     emit(RemoteCategoriaFailure(dataState.exception));
  //   }
  // }

  // Future<void> _onUpdateCategoria(UpdateCategoria event, Emitter<RemoteCategoriaState> emit) async {
  //   emit(RemoteCategoriaLoading());

  //   final dataState = await _updateCategoriaUseCase(event.CategoriaReq);

  //   if (dataState is DataSuccess) {
  //     emit(RemoteCategoriaCreateDone(dataState.data!));
  //   }

  //   if (dataState is DataFailedMessage) {
  //     emit(RemiteCategoriaFailedMessage(dataState.errorMessage));
  //   }

  //   if (dataState is DataFailed) {
  //     emit(RemoteCategoriaFailure(dataState.exception));
  //   }
  // }

  // Future<void> _onDeleteCategoria(DeleteCategoria event, Emitter<RemoteCategoriaState> emit) async {
  //   emit(RemoteCategoriaLoading());

  //   final dataState = await _deleteCategoriaUseCase(event.idCategoria);

  //   if (dataState is DataSuccess) {
  //     emit(RemoteCategoriaCreateDone(dataState.data!));
  //   }

  //   if (dataState is DataFailedMessage) {
  //     emit(RemiteCategoriaFailedMessage(dataState.errorMessage));
  //   }

  //   if (dataState is DataFailed) {
  //     emit(RemoteCategoriaFailure(dataState.exception));
  //   }
  // }
}
