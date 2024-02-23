import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/create_inspeccion.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_state.dart';
import 'package:eos_mobile/shared/shared.dart';

class RemoteCreateInspeccionBloc extends Bloc<RemoteCreateInspeccionEvent, RemoteCreateInspeccionState> {
  RemoteCreateInspeccionBloc(this._createInspeccionUseCase) : super(const RemoteCreateInspeccionLoading()) {
    on<CreateInspeccion> (onCreateInspeccion);
  }

  final CreateInspeccionUseCase _createInspeccionUseCase;

  Future<void> onCreateInspeccion(CreateInspeccion event, Emitter<RemoteCreateInspeccionState> emit) async {
    final dataState = await _createInspeccionUseCase(params: event.inspeccion);

    if (dataState is DataSuccess) {
      print(dataState);
      emit(const RemoteCreateInspeccionDone('Inspección creada exitosamente'));
    }

    if (dataState is DataFailed) {
      emit(RemoteCreateInspeccionFailure(dataState.exception!));
    }
  }
}
