import 'package:eos_mobile/core/network/data_state.dart';
import 'package:eos_mobile/features/configuraciones/domain/usecases/create_inspeccion.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/create/remote/remote_create_inspeccion_state.dart';
import 'package:eos_mobile/shared/shared.dart';

class RemoteCreateInspeccionBloc extends Bloc<RemoteCreateInspeccionEvent, RemoteCreateInspeccionState> {
  RemoteCreateInspeccionBloc(this._createInspeccionUseCase) : super(const RemoteCreateInspeccionInitial()) {
    on<CreateInspeccion> (onCreateInspeccion);
  }

  final CreateInspeccionUseCase _createInspeccionUseCase;

  Future<void> onCreateInspeccion(CreateInspeccion event, Emitter<RemoteCreateInspeccionState> emit) async {
    emit(const RemoteCreateInspeccionLoading());

    final dataState = await _createInspeccionUseCase(params: event.inspeccion);

    if (dataState is DataSuccess) {
      print(dataState.data!);
      emit(RemoteCreateInspeccionDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.exception!.message);
      emit(RemoteCreateInspeccionFailure(dataState.exception!));
    }
  }
}
