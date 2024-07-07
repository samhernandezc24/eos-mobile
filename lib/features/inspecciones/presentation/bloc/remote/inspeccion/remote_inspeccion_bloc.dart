import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_create_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/entities/inspeccion/inspeccion_store_req_entity.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion/remote_create_inspeccion_usecase.dart';
import 'package:eos_mobile/features/inspecciones/domain/usecases/remote/inspeccion/remote_store_inspeccion_usecase.dart';

import 'package:eos_mobile/shared/shared_libs.dart';

part 'remote_inspeccion_event.dart';
part 'remote_inspeccion_state.dart';

class RemoteInspeccionBloc extends Bloc<RemoteInspeccionEvent, RemoteInspeccionState> {
  RemoteInspeccionBloc(
    this._remoteCreateInspeccionUseCase,
    this._remoteStoreInspeccionUseCase,
  ) : super(RemoteInspeccionInit()) {
    on<CreateInspeccion>(onCreateInspeccion);
    on<StoreInspeccion>(onStoreInspeccion);
  }

  // USE CASES
  final RemoteCreateInspeccionUseCase _remoteCreateInspeccionUseCase;
  final RemoteStoreInspeccionUseCase _remoteStoreInspeccionUseCase;

  Future<void> onCreateInspeccion(CreateInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionCreateLoading());

    final objDataState = await _remoteCreateInspeccionUseCase(params: NoParams());

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionCreate(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageCreate(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerExceptionMessageCreate(objDataState.error));
    }
  }

  Future<void> onStoreInspeccion(StoreInspeccion event, Emitter<RemoteInspeccionState> emit) async {
    emit(RemoteInspeccionStoreLoading());

    final objDataState = await _remoteStoreInspeccionUseCase(params: event.objData);

    if (objDataState is DataSuccess) {
      emit(RemoteInspeccionStore(objDataState.data));
    }

    if (objDataState is DataFailedMessage) {
      emit(RemoteInspeccionServerFailedMessageStore(objDataState.errorMessage));
    }

    if (objDataState is DataFailed) {
      emit(RemoteInspeccionServerExceptionMessageStore(objDataState.error));
    }
  }
}
