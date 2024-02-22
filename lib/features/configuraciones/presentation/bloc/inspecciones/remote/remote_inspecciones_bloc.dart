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
      emit(
        RemoteInspeccionesDone(dataState.data!),
      );
    }

    if (dataState is DataFailed) {
      emit(RemoteInspeccionesFailure(dataState.exception!));
    }
  }

  // Stream<RemoteInspeccionesState> mapEventToState(RemoteInspeccionesEvent event) async* {
  //   if (event is GetInspeccionesEvent) {
  //     yield*  _mapGetInspeccionesEventToState(event);
  //   }
  // }

  // Stream<RemoteInspeccionesState> _mapGetInspeccionesEventToState(GetInspeccionesEvent event) async* {
  //   yield const RemoteInspeccionesLoading();
  //   final eitherFailureOrInspecciones = await getInspeccionesUseCase();

  //   yield eitherFailureOrInspecciones.fold((f) => RemoteInspeccionesFailure(f), (r) => RemoteInspeccionesDone(r));
  // }
}
