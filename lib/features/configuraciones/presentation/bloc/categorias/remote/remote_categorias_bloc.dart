import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/get_categorias_by_id_inspeccion_usecase.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categorias/remote/remote_categorias_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/categorias/remote/remote_categorias_state.dart';
import 'package:eos_mobile/shared/shared.dart';

class RemoteCategoriasBloc extends Bloc<RemoteCategoriasEvent, RemoteCategoriasState> {
  RemoteCategoriasBloc(this._getCategoriasByIdUseCase) : super(
    const RemoteCategoriasLoading(),
  ) {
    on<GetCategoriasByIdInspeccion> (onGetCategoriasByIdInspeccion);
  }

  final GetCategoriasByIdUseCase _getCategoriasByIdUseCase;

  Future<void> onGetCategoriasByIdInspeccion(GetCategoriasByIdInspeccion event, Emitter<RemoteCategoriasState> emit) async {
    final dataState = await _getCategoriasByIdUseCase(event.inspeccionId!);

    if (dataState is DataSuccess) {
      if (dataState.data!.isEmpty) {
        emit(const RemoteCategoriasEmpty());
      } else {
        print(dataState.data!);
        emit(RemoteCategoriasDone(dataState.data!));
      }
    }

    if (dataState is DataFailed) {
      print(dataState.exception);
      emit(RemoteCategoriasFailure(dataState.exception!));
    }
  }
}
