import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/get_inspecciones.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_state.dart';
import 'package:eos_mobile/shared/shared.dart';

class RemoteInspeccionesBloc extends Bloc<RemoteInspeccionesEvent, RemoteInspeccionesState> {

  RemoteInspeccionesBloc(this._getInspeccionesUseCase) : super(const RemoteInspeccionesLoading()) {
    on<GetInspecciones> (onGetInspecciones);
  }

  final GetInspeccionesUseCase _getInspeccionesUseCase;

  Future<void> onGetInspecciones(GetInspecciones event, Emitter<RemoteInspeccionesState> emit) async {
    final dataState = await _getInspeccionesUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // print(dataState.data!);
      emit(
        RemoteInspeccionesDone(dataState.data!),
      );
    }

    if (dataState is DataFailed) {
      // print(dataState.exception!.message);
      emit(RemoteInspeccionesFailure(dataState.exception!));
    }
  }
}
